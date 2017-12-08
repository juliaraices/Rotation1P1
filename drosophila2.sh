#!/bin/bash
#
#SBATCH --job-name="quality_jarvisi_ds"
#SBATCH --time=96:00:00
#SBATCH --mem=10GB
#SBATCH --mail-user=julia.raices@ist.ac.at
#SBATCH --mail-type=ALL
#SBATCH --no-requeue

export OMP_NUM_THREADS=1

module load java
module load fastqc

# get fastq qualities for all expreiments
srun --cpu_bind=verbose fastqc SRR072915.fastq
srun --cpu_bind=verbose fastqc SRR072914.fastq
srun --cpu_bind=verbose fastqc SRR072913.fastq
srun --cpu_bind=verbose fastqc SRR072912.fastq
srun --cpu_bind=verbose fastqc SRR072911.fastq
srun --cpu_bind=verbose fastqc SRR072909.fastq
srun --cpu_bind=verbose fastqc SRR072907.fastq
srun --cpu_bind=verbose fastqc SRR072906.fastq
srun --cpu_bind=verbose fastqc SRR072905.fastq

