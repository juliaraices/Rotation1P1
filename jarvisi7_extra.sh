#!/bin/bash
#
#SBATCH --job-name="indexing the transcriptome" # job name
#SBATCH --time=96:00:00 #maximum runtime
#SBATCH --mem=10G #maximum memmory allocation
#SBATCH --mail-user=julia.raices@ist.ac.at #send e-mail to user at end or error
#SBATCH --mail-type=ALL
# SBATCH -p main.q # gave an error....

module load kallisto
srun kallisto index -i jarvisi.idx --make-unique Bjar_vs_Dro2.blast
