#!/bin/bash
#
#SBATCH --job-name="trimm drosophila seqs" # job name
#SBATCH --time=96:00:00 #maximum runtime
#SBATCH --mem=10G #maximum memmory allocation
#SBATCH --mail-user=julia.raices@ist.ac.at #send e-mail to user at end or error
#SBATCH --mail-type=ALL
#SBATCH --no-requeue

export OMP_NUM_THREADS=1

# for each experiment remove low quality reads
srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar SE -phred33 SRR072915.fastq SRR072915_1_unpaired.fastq ILLUMINACLIP:TruSeq3-SE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar SE -phred33 SRR072914.fastq SRR072914_1_unpaired.fastq ILLUMINACLIP:TruSeq3-SE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar SE -phred33 SRR072913.fastq SRR072913_1_unpaired.fastq ILLUMINACLIP:TruSeq3-SE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar SE -phred33 SRR072912.fastq SRR072912_1_unpaired.fastq ILLUMINACLIP:TruSeq3-SE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar SE -phred33 SRR072911.fastq SRR072911_1_unpaired.fastq ILLUMINACLIP:TruSeq3-SE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar SE -phred33 SRR072909.fastq SRR072909_1_unpaired.fastq ILLUMINACLIP:TruSeq3-SE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar SE -phred33 SRR072907.fastq SRR072907_1_unpaired.fastq ILLUMINACLIP:TruSeq3-SE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar SE -phred33 SRR072906.fastq SRR072906_1_unpaired.fastq ILLUMINACLIP:TruSeq3-SE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

srun --cpu_bind=verbose java -jar Trimmomatic-0.36/trimmomatic-0.36.jar SE -phred33 SRR072905.fastq SRR072905_1_unpaired.fastq ILLUMINACLIP:TruSeq3-SE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

