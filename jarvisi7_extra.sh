#!/bin/bash
#
<<<<<<< HEAD
#SBATCH --job-name="indexing the transcriptome" # job name
=======
#SBATCH --job-name="indexing the transcriptome with sisA and upd3" # job name
>>>>>>> a31fe549af1d22f66e8a7f22941d79ad3a5e4c21
#SBATCH --time=96:00:00 #maximum runtime
#SBATCH --mem=10G #maximum memmory allocation
#SBATCH --mail-user=julia.raices@ist.ac.at #send e-mail to user at end or error
#SBATCH --mail-type=ALL
# SBATCH -p main.q # gave an error....

module load kallisto
<<<<<<< HEAD
srun kallisto index -i jarvisi.idx --make-unique Bjar_vs_Dro2.blast
=======
# creates an index for the scaffolds related to each drosophila gene, in the expanded table (including upd3 and sisA)
srun --cpu_bind=verbose kallisto index -i jarvisi2.idx --make-unique Bjar_vs_Dro_upd3_sisA.fasta
>>>>>>> a31fe549af1d22f66e8a7f22941d79ad3a5e4c21
