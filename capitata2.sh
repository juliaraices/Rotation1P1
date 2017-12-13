#!/bin/bash
#
#SBATCH --job-name="Scaffolding to Drosophila Genes"
#SBATCH --time=96:00:00
#SBATCH --mem=10G
#SBATCH --mail-user=julia.raices@ist.ac.at
#SBATCH --mail-type=ALL

<<<<<<< HEAD
export LC_ALL=C

srun --cpu_bind=verbose ./blat -t=dnax -q=dnax -minScore=50 Ccap01172013-genome.fa dmel-all-CDS-r6.18_clean.sorted.longestCDS3 Dmel_vs_Ccap.blat
=======
srun --cpu_bind=verbose ./blat -t=dnax -q=dnax -minScore=50 dmel-all-CDS-r6.18_clean.sorted.longestCDS3 Ccap01172013-genome.fa Dmel_vs_Ccap.blat
>>>>>>> a31fe549af1d22f66e8a7f22941d79ad3a5e4c21
# runs blat comparing translated proteins to translated proteins from two dna samples

#first let's make sure that each transcript only maps to a single reference gene

srun --cpu_bind=verbose awk '{if($1 ~ /^[0-9]/) print $0}' Dmel_vs_Ccap.blat >Dmel_vs_Ccap_noheader.blat

srun --cpu_bind=verbose sort -k 10 Dmel_vs_Ccap_noheader.blat >Dmel_vs_Ccap_noheader.blat.sorted

srun --cpu_bind=verbose perl 2-besthitblat.pl Dmel_vs_Ccap_noheader.blat.sorted


#Now let's make sure that transcripts that map to the same gene are removed if they overlap (by at least 20bps)

srun --cpu_bind=verbose sort -k 14 Dmel_vs_Ccap_noheader.blat.sorted.besthit > Dmel_vs_Ccap.blat.sortedbyDB

srun --cpu_bind=verbose perl redremov_genome.pl Dmel_vs_Ccap.blat.sortedbyDB

