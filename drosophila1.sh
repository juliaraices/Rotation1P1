#!/bin/bash
#
#SBATCH --job-name="get_drosophila_dataset" # job name
#SBATCH --time=96:00:00 #maximum runtime
#SBATCH --mem=10G #maximum memmory allocation
#SBATCH --mail-user=julia.raices@ist.ac.at #send e-mail to user at end or error
#SBATCH --mail-type=ALL
#SBATCH -n 5 # set cpu/parallel computing count to 5
#SBATCH --no-requeue

export OMP_NUM_THREADS=1

# loads module where raw data should be downloaded from
module load SRA-Toolkit/2.8.1-3

# downloads reads for each experiment
srun --cpu_bind=verbose fastq-dump --skip-technical --readids SRR072915
srun --cpu_bind=verbose fastq-dump --skip-technical --readids SRR072914
srun --cpu_bind=verbose fastq-dump --skip-technical --readids SRR072913
srun --cpu_bind=verbose fastq-dump --skip-technical --readids SRR072912
srun --cpu_bind=verbose fastq-dump --skip-technical --readids SRR072911
srun --cpu_bind=verbose fastq-dump --skip-technical --readids SRR072909
srun --cpu_bind=verbose fastq-dump --skip-technical --readids SRR072907
srun --cpu_bind=verbose fastq-dump --skip-technical --readids SRR072906
srun --cpu_bind=verbose fastq-dump --skip-technical --readids SRR072905
