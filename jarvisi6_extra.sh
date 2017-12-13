#!/bin/bash
#
#SBATCH --job-name="Scaffolding to Drosophila Genes"
#SBATCH --time=96:00:00
#SBATCH --mem=10G
#SBATCH --mail-user=julia.raices@ist.ac.at
#SBATCH --mail-type=ALL

# makes database for blast to use
srun --cpu_bind=verbose makeblastdb -in interest.sorted.longestCDS -dbtype 'nucl' -out interestgenesDB

#runs blast comparing translated protein from dna sequences
srun --cpu_bind=verbose tblastx -db interestgenesDB -query ../jarvisi_assembly.scafSeq -outfmt 7 -max_target_seqs 1 -num_threads 16 -evalue 1e-10 -max_hsps 1 -out Bjar_vs_Dro2.blast

#first let's make sure that each transcript only maps to a single reference gene

#srun awk '{if($1 ~ /^[0-9]/) print $0}' Bjar_vs_Dro2.blat >Bjar_vs_Dro2_noheader.blat

#srun sort -k 10 Bjar_vs_Dro2_noheader.blat > Bjar_vs_Dro2.blat.sorted

#srun perl 1-besthitblat.pl Bjar_vs_Dro.blat.sorted


#Now let's make sure that transcripts that map to the same gene are removed if they overlap (by at least 20bps)

#srun sort -k 14 Bjar_vs_Dro.blat.sorted.besthit > Bjar_vs_Dro.blat.sortedbyDB

#srun perl 2-redremov_blat.pl Bjar_vs_Dro.blat.sortedbyDB


#Finally let's concatenate all the transcripts that map to a single gene (without overlapping)

#srun sort -n -k14,14 -k16,16 Bjar_vs_Dro.blat.sortedbyDB.nonredundant > Bjar_vs_Dro.inputforconcat

#srun perl 3-concatenator.pl jarvisi_assembly.scafSeq Bjar_vs_Dro.inputforconcat

