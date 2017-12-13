#!/bin/bash
#
#SBATCH --job-name="get_jarvisi_dataset" # job name
#SBATCH --time=96:00:00 #maximum runtime
#SBATCH --mem=10G #maximum memmory allocation
#SBATCH --mail-user=julia.raices@ist.ac.at #send e-mail to user at end or error
#SBATCH --mail-type=ALL
# SBATCH --gres=mathematica:0 #set (resource) mathematica specification to 0
# SBATCH -n 5 # set cpu/parallel computing count to 5

# loads module from which raw data should be dowloaded
module load SRA-Toolkit/2.8.1-3

# downloads reads for each experiment
fastq-dump --skip-technical --readids --split-files SRR1571030
fastq-dump --skip-technical --readids --split-files SRR1571085
fastq-dump --skip-technical --readids --split-files SRR1571147
fastq-dump --skip-technical --readids --split-files SRR1571155
fastq-dump --skip-technical --readids --split-files SRR1571157
fastq-dump --skip-technical --readids --split-files SRR1571159
fastq-dump --skip-technical --readids --split-files SRR1571160
fastq-dump --skip-technical --readids --split-files SRR1571161
