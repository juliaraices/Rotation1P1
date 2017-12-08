#!/bin/bash
#
#SBATCH --job-name="quality jarvisi after trimm"
#SBATCH --time=96:00:00
#SBATCH --mem=10GB
#SBATCH --mail-user=julia.raices@ist.ac.at
#SBATCH --mail-type=ALL
#SBATCH --no-requeue

export OMP_NUM_THREADS=1

module load java
module load fastqc

# check for the quality of reads after removing the low quality ones
srun --cpu_bind=verbose fastqc SRR072915_1_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR072914_1_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR072913_1_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR072912_1_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR072911_1_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR072909_1_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR072907_1_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR072906_1_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR072905_1_unpaired.fastq

