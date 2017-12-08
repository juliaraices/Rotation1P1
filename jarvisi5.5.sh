#!/bin/bash
#
#SBATCH --job-name="geting longest CDS and sorting Drosophila Genes"
#SBATCH --time=96:00:00
#SBATCH --mem=10G
#SBATCH --mail-user=julia.raices@ist.ac.at
#SBATCH --mail-type=ALL

# This is what I did directly in the command line, because for some reason it doesn't wrk when I run this scrpt, but works when I run them in the comand line ¯\_(ツ)_/¯

cat dmel-all-CDS-r6.18.fasta | perl -pi -e 's/-P.//gi' > dmel-all-CDS-r6.18_clean.fasta
# removes -* after gene names

cat dmel-all-CDS-r6.18_clean.fasta | perl -pi -e 's/ .*//gi' | perl -pi -e 's/\n/ /gi' | perl -pi -e 's/>/\n/gi' | sort -V -k 1 | perl -pi -e 's/\n/\n>/gi' | perl -pi -e 's/ /\n/gi' > dmel-all-CDS-r6.18_clean.sorted
# removes empty lines, and lines without gene name

perl -pi -e 's/^\n//gi' dmel-all-CDS-r6.18_clean.sorted
# removes empty lines

perl getlongestCDS.pl dmel-all-CDS-r6.18_clean.sorted
# gets longest CDS for that each of the genes

#cat jarvisi_assembly.scafSeq | perl -pi -e 's/ .*//gi' | perl -pi -e 's/\n/ /gi' | perl -pi -e 's/>/\n/gi' | sort -V -k 1 | perl -pi -e 's/\n/\n>/gi' | perl -pi -e 's/ /\n/gi' > jarvisi_assembly.scafSeq.sorted

