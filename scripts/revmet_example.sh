#!/bin/bash

start=`date +%s`

skim_refs_dir=skim_refs
nanopore_reads=nanopore_reads/mock_mix_1_1.fasta
output_dir=output
scripts_dir=scripts
mapq=0
include_flag_f=0
exclude_flag_F=2308

nanopore_sample=$(basename -s .fasta $nanopore_reads)

#Make output directory if it does not already exist
if [ ! -d "$output_dir" ]; then
  mkdir $output_dir
fi

#Loop through reference skims, mapping each of them to the nanopore reads
for skim_R1 in ${skim_refs_dir}/*R1*fastq.gz
  do skim_ref=$(basename -s .fastq.gz $skim_R1 | sed 's/_R1//g')
  alignment_out=${output_dir}/${skim_ref}_${nanopore_sample}
  samtools_out=${alignment_out}_q${mapq}_f${include_flag_f}_F${exclude_flag_F}
  skim_R2=$(echo $skim_R1 | sed 's/R1/R2/g')
  printf "\nMapping $skim_ref to $nanopore_sample \n\n"
  minimap2 -ax sr $nanopore_reads $skim_R1 $skim_R2 > ${alignment_out}.sam
  #Filter and sort sam alignment file then output as bam
  samtools view -bu -F $exclude_flag_F -f $include_flag_f -q $mapq ${alignment_out}.sam \
    | samtools sort - -o ${samtools_out}.bam
  samtools index -c ${samtools_out}.bam
  #Get coverage at each position on each nanopore read
  samtools depth -a ${samtools_out}.bam > ${samtools_out}.depth
  #Calculate percent coverage for each nanopore read
  python ${scripts_dir}/percent_coverage_from_depth_file.py ${samtools_out}.depth $skim_ref \
    > ${samtools_out}.pc
  #Remove sam, bam and depth files
  rm ${alignment_out}.sam
  rm ${samtools_out}.bam*
  rm ${samtools_out}.depth
  done

#Remove concatenated pc file if it already exists
if [ -f "$output_dir/all_$nanopore_sample.pc" ]; then
  rm ${output_dir}/all_${nanopore_sample}.pc
fi

#Concatenate all pc files
for pc in ${output_dir}/*.pc
do cat $pc >> ${output_dir}/all_${nanopore_sample}.pc
#Remove pc files
rm $pc
done

#Get list of nanopore read ids from nanopore fasta
cat $nanopore_reads | grep ">" | awk '{print $1}' | sed 's/>//g' \
> ${output_dir}/${nanopore_sample}.ids

#Bin each nanopore read to reference which has the highest pc
python ${scripts_dir}/minion_read_bin_from_perc_cov.py ${output_dir}/all_${nanopore_sample}.pc \
${output_dir}/${nanopore_sample}.ids > ${output_dir}/all_${nanopore_sample}.binned

#Remove nanopore id and conatenated pc files
rm ${output_dir}/${nanopore_sample}.ids
rm ${output_dir}/all_${nanopore_sample}.pc

#Remove skim reference ids if it already exists
if [ -f "$output_dir/skim_ref.ids" ]; then
  rm $output_dir/skim_ref.ids
fi

#Get list of skim reference ids
for skim_R1 in ${skim_refs_dir}/*R1*fastq.gz
do skim_ref=$(basename -s .fastq.gz $skim_R1 | sed 's/_R1//g')
echo $skim_ref >> ${output_dir}/skim_ref.ids
done; echo "unassigned" >> ${output_dir}/skim_ref.ids

#Count number of reads binned to each reference
python ${scripts_dir}/minion_read_bin_counts_from_perc_cov_binned_with_threshold.py \
${output_dir}/all_${nanopore_sample}.binned ${output_dir}/skim_ref.ids 15 99.9 \
| sort -k1 -V > ${output_dir}/${nanopore_sample}_bin_counts.txt

#Remove binned and skim ref ids files
rm ${output_dir}/all_${nanopore_sample}.binned
rm ${output_dir}/skim_ref.ids

#Convert read bin counts to percentages and apply minimum threshold
python ${scripts_dir}/convert_minion_read_counts_to_percentages.py \
${output_dir}/${nanopore_sample}_bin_counts.txt \
> ${output_dir}/${nanopore_sample}_bin_percentges.txt

end=`date +%s`
runtime=$((end-start))

printf "\nRevMet analysis finished in $runtime seconds \n\n"
