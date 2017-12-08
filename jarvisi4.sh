#!/bin/bash
#
#SBATCH --job-name="quality jarvisi after trimm"
#SBATCH --time=96:00:00
#SBATCH --mem=10GB
#SBATCH --mail-user=julia.raices@ist.ac.at
#SBATCH --mail-type=ALL
# SBATCH --gres=mathematica:0 # set (resource) mathematica specification to 0
#SBATCH --nodes=5 #set cpu/parallel computing to 5 nodes

export OMP_NUM_THREADS=1

module load java
module load fastqc

# check for the quality of reads after removing the low quality ones
srun --cpu_bind=verbose fastqc SRR1571030_1_paired.fastq
srun --cpu_bind=verbose fastqc SRR1571030_1_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR1571030_2_paired.fastq
srun --cpu_bind=verbose fastqc SRR1571030_2_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR1571085_1_paired.fastq
srun --cpu_bind=verbose fastqc SRR1571085_1_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR1571085_2_paired.fastq
srun --cpu_bind=verbose fastqc SRR1571085_2_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR1571147_1_paired.fastq
srun --cpu_bind=verbose fastqc SRR1571147_1_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR1571147_2_paired.fastq
srun --cpu_bind=verbose fastqc SRR1571147_2_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR1571155_1_paired.fastq
srun --cpu_bind=verbose fastqc SRR1571155_1_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR1571155_2_paired.fastq
srun --cpu_bind=verbose fastqc SRR1571155_2_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR1571157_1_paired.fastq
srun --cpu_bind=verbose fastqc SRR1571157_1_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR1571157_2_paired.fastq
srun --cpu_bind=verbose fastqc SRR1571157_2_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR1571159_1_paired.fastq
srun --cpu_bind=verbose fastqc SRR1571159_1_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR1571159_2_paired.fastq
srun --cpu_bind=verbose fastqc SRR1571159_2_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR1571160_1_paired.fastq
srun --cpu_bind=verbose fastqc SRR1571160_1_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR1571160_2_paired.fastq
srun --cpu_bind=verbose fastqc SRR1571160_2_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR1571161_1_paired.fastq
srun --cpu_bind=verbose fastqc SRR1571161_1_unpaired.fastq
srun --cpu_bind=verbose fastqc SRR1571161_2_paired.fastq
srun --cpu_bind=verbose fastqc SRR1571161_2_unpaired.fastq

