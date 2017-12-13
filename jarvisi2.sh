#!/bin/bash
#
#SBATCH --job-name="quality_jarvisi_ds"
#SBATCH --time=96:00:00
#SBATCH --mem=10GB
#SBATCH --mail-user=julia.raices@ist.ac.at
#SBATCH --mail-type=ALL
# SBATCH --gres=mathematica:0 # set (resource) mathematica specification to 0
# SBATCH -n 5 #set cpu/parallel computing to 5 nodes

export OMP_NUM_THREADS=1

module load java
module load fastqc

# get fast qualities for all experiments
srun --cpu_bind=verbose fastqc SRR1571030_1.fastq
srun --cpu_bind=verbose fastqc SRR1571030_2.fastq
srun --cpu_bind=verbose fastqc SRR1571085_1.fastq
srun --cpu_bind=verbose fastqc SRR1571085_2.fastq
srun --cpu_bind=verbose fastqc SRR1571147_1.fastq
srun --cpu_bind=verbose fastqc SRR1571147_2.fastq
srun --cpu_bind=verbose fastqc SRR1571155_1.fastq
srun --cpu_bind=verbose fastqc SRR1571155_2.fastq
srun --cpu_bind=verbose fastqc SRR1571157_1.fastq
srun --cpu_bind=verbose fastqc SRR1571157_2.fastq
srun --cpu_bind=verbose fastqc SRR1571159_1.fastq
srun --cpu_bind=verbose fastqc SRR1571159_2.fastq
srun --cpu_bind=verbose fastqc SRR1571160_1.fastq
srun --cpu_bind=verbose fastqc SRR1571160_2.fastq
srun --cpu_bind=verbose fastqc SRR1571161_1.fastq
srun --cpu_bind=verbose fastqc SRR1571161_2.fastq
