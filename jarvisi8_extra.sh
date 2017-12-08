#!/bin/bash
#
#SBATCH --job-name="mapping and quantification with sisA and upd3" # job name
#SBATCH --time=96:00:00 #maximum runtime
#SBATCH --mem=10G #maximum memmory allocation
#SBATCH --mail-user=julia.raices@ist.ac.at #send e-mail to user at end or error
#SBATCH --mail-type=ALL
#SBATCH --no-requeue

export OMP_NUM_THREADS=1
module load kallisto

# for each experiment construct the final expression data (including TPMs and ESTs) for the expanded table with upd3 and sisA
srun --cpu_bind=verbose  kallisto quant -t 16 -i jarvisi2.idx -o SRR1571030_extras -b 100 SRR1571030_1_paired.fastq SRR1571030_2_paired.fastq

srun --cpu_bind=verbose kallisto quant -t 16 -i jarvisi2.idx -o SRR1571085_extras -b 100 SRR1571085_1_paired.fastq SRR1571085_2_paired.fastq

srun --cpu_bind=verbose kallisto quant -t 16 -i jarvisi2.idx -o SRR1571147_extras -b 100 SRR1571147_1_paired.fastq SRR1571147_2_paired.fastq

srun --cpu_bind=verbose kallisto quant -t 16 -i jarvisi2.idx -o SRR1571155_extras -b 100 SRR1571155_1_paired.fastq SRR1571155_2_paired.fastq

srun --cpu_bind=verbose kallisto quant -t 16 -i jarvisi2.idx -o SRR1571157_extras -b 100 SRR1571157_1_paired.fastq SRR1571157_2_paired.fastq

srun --cpu_bind=verbose kallisto quant -t 16 -i jarvisi2.idx -o SRR1571159_extras -b 100 SRR1571159_1_paired.fastq SRR1571159_2_paired.fastq

srun --cpu_bind=verbose kallisto quant -t 16 -i jarvisi2.idx -o SRR1571160_extras -b 100 SRR1571160_1_paired.fastq SRR1571160_2_paired.fastq

srun --cpu_bind=verbose kallisto quant -t 16 -i jarvisi2.idx -o SRR1571161_extras -b 100 SRR1571161_1_paired.fastq SRR1571161_2_paired.fastq
