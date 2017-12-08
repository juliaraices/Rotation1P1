#!/bin/bash
#
#SBATCH --job-name="Scaffolding to Drosophila Genes"
#SBATCH --time=96:00:00
#SBATCH --mem=10G
#SBATCH --mail-user=julia.raices@ist.ac.at
#SBATCH --mail-type=ALL

srun --cpu_bind=verbose cat dmel-all-CDS-r6.18_clean.sorted.longestCDS | perl -pi -e 's/>$//gi' > dmel-all-CDS-r6.18_clean.sorted.longestCDS3
# removes lines without gene name

srun --cpu_bind=verbose ./blat -t=dnax -q=dnax -minScore=50 dmel-all-CDS-r6.18_clean.sorted.longestCDS3 jarvisi_assembly.scafSeq Bjar_vs_Dro.blat
# runs blat comparing translated proteins to translated proteins from two dna samples

#first let's make sure that each transcript only maps to a single reference gene

srun --cpu_bind=verbose awk '{if($1 ~ /^[0-9]/) print $0}' Bjar_vs_Dro.blat >Bjar_vs_Dro_noheader.blat

srun --cpu_bind=verbose sort -k 10 Bjar_vs_Dro_noheader.blat > Bjar_vs_Dro.blat.sorted

srun --cpu_bind=verbose perl 1-besthitblat.pl Bjar_vs_Dro.blat.sorted


#Now let's make sure that transcripts that map to the same gene are removed if they overlap (by at least 20bps)

srun --cpu_bind=verbose sort -k 14 Bjar_vs_Dro.blat.sorted.besthit > Bjar_vs_Dro.blat.sortedbyDB

srun --cpu_bind=verbose perl 2-redremov_blat.pl Bjar_vs_Dro.blat.sortedbyDB


#Finally let's concatenate all the transcripts that map to a single gene (without overlapping)

srun --cpu_bind=verbose sort -n -k14,14 -k16,16 Bjar_vs_Dro.blat.sortedbyDB.nonredundant > Bjar_vs_Dro.inputforconcat

srun --cpu_bind=verbose perl 3-concatenator.pl jarvisi_assembly.scafSeq Bjar_vs_Dro.inputforconcat

