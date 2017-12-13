#!/bin/bash
#
#SBATCH --job-name="get c. capitata dataset" # job name
#SBATCH --time=96:00:00 #maximum runtime
#SBATCH --mem=10G #maximum memmory allocation
#SBATCH --mail-user=julia.raices@ist.ac.at #send e-mail to user at end or error
#SBATCH --mail-type=ALL
#SBATCH -n 1 # set cpu/parallel computing count to 1
#SBATCH --no-requeue

export OMP_NUM_THREADS=1

# downloads C. capitata genome
srun --cpu_bind=verbose wget https://i5k.nal.usda.gov/data/Arthropoda/cercap-%28Ceratitis_capitata%29/Current%20Genome%20Assembly/1.Genome%20Assembly/BCM-After-Atlas/Scaffolds/Ccap01172013-genome.fa.gz

#unzips the downloaded package:
srun --cpu_bind=verbose gzip Ccap01172013-genome.fa.gz

