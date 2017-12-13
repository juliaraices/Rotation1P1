#!/bin/bash
#
#SBATCH --job-name="trimm jarvisi seqs" # job name
#SBATCH --time=96:00:00 #maximum runtime
#SBATCH --mem=10G #maximum memmory allocation
#SBATCH --mail-user=julia.raices@ist.ac.at #send e-mail to user at end or error
#SBATCH --mail-type=ALL
#SBATCH --nodes=5 # set cpu/parallel computing count to 5

export OMP_NUM_THREADS=1

# for each experiment remove low quality reads
srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 SRR1571030_1.fastq SRR1571030_2.fastq SRR1571030_1_paired.fastq SRR1571030_1_unpaired.fastq SRR1571030_2_paired.fastq SRR1571030_2_unpaired.fastq ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 SRR1571085_1.fastq SRR1571085_2.fastq SRR1571085_1_paired.fastq SRR1571085_1_unpaired.fastq SRR1571085_2_paired.fastq SRR1571085_2_unpaired.fastq ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 SRR1571147_1.fastq SRR1571147_2.fastq SRR1571147_1_paired.fastq SRR1571147_1_unpaired.fastq SRR1571147_2_paired.fastq SRR1571147_2_unpaired.fastq ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 SRR1571155_1.fastq SRR1571155_2.fastq SRR1571155_1_paired.fastq SRR1571155_1_unpaired.fastq SRR1571155_2_paired.fastq SRR1571155_2_unpaired.fastq ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 SRR1571157_1.fastq SRR1571157_2.fastq SRR1571157_1_paired.fastq SRR1571157_1_unpaired.fastq SRR1571157_2_paired.fastq SRR1571157_2_unpaired.fastq ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 SRR1571159_1.fastq SRR1571159_2.fastq SRR1571159_1_paired.fastq SRR1571159_1_unpaired.fastq SRR1571159_2_paired.fastq SRR1571159_2_unpaired.fastq ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 SRR1571160_1.fastq SRR1571160_2.fastq SRR1571160_1_paired.fastq SRR1571160_1_unpaired.fastq SRR1571160_2_paired.fastq SRR1571160_2_unpaired.fastq ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 SRR1571161_1.fastq SRR1571161_2.fastq SRR1571161_1_paired.fastq SRR1571161_1_unpaired.fastq SRR1571161_2_paired.fastq SRR1571161_2_unpaired.fastq ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36


