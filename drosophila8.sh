#!/bin/bash
#
#SBATCH --job-name="drosophila mapping and quantification" # job name
#SBATCH --time=96:00:00 #maximum runtime
#SBATCH --mem=10G #maximum memmory allocation
#SBATCH --mail-user=julia.raices@ist.ac.at #send e-mail to user at end or error
#SBATCH --mail-type=ALL
#SBATCH --no-requeue

export OMP_NUM_THREADS=1
module load kallisto

# for each experiment construct the final expression data, with TPMs and ESTs
srun --cpu_bind=verbose kallisto quant -t 16 -i drosophila.idx -o SRR072915 -b 100 --single -l 200 -s 20 SRR072915_1_unpaired.fastq

srun --cpu_bind=verbose kallisto quant -t 16 -i drosophila.idx -o SRR072914 -b 100 --single -l 200 -s 20 SRR072914_1_unpaired.fastq

srun --cpu_bind=verbose kallisto quant -t 16 -i drosophila.idx -o SRR072913 -b 100 --single -l 200 -s 20 SRR072913_1_unpaired.fastq

srun --cpu_bind=verbose kallisto quant -t 16 -i drosophila.idx -o SRR072912 -b 100 --single -l 200 -s 20 SRR072912_1_unpaired.fastq

srun --cpu_bind=verbose kallisto quant -t 16 -i drosophila.idx -o SRR072911 -b 100 --single -l 200 -s 20 SRR072911_1_unpaired.fastq

srun --cpu_bind=verbose kallisto quant -t 16 -i drosophila.idx -o SRR072909 -b 100 --single -l 200 -s 20 SRR072909_1_unpaired.fastq

srun --cpu_bind=verbose kallisto quant -t 16 -i drosophila.idx -o SRR072907 -b 100 --single -l 200 -s 20 SRR072907_1_unpaired.fastq

srun --cpu_bind=verbose kallisto quant -t 16 -i drosophila.idx -o SRR072906 -b 100 --single -l 200 -s 20 SRR072906_1_unpaired.fastq

srun --cpu_bind=verbose kallisto quant -t 16 -i drosophila.idx -o SRR072905 -b 100 --single -l 200 -s 20 SRR072905_1_unpaired.fastq

