#!/bin/bash
#
#SBATCH --job-name="geting longest CDS and sorting Drosophila Genes"
#SBATCH --time=96:00:00
#SBATCH --mem=10G
#SBATCH --mail-user=julia.raices@ist.ac.at
#SBATCH --mail-type=ALL
#SBATCH --no-requeue

export OMP_NUM_THREADS=1

# This is what I did directly in the command line, because for some reason it doesn't wrk when I run this scrpt, but works when I run them in the comand line ¯\_(ツ)_/¯

srun --cpu_bind=verbose cat FlyBase_FastA_interestgenes.txt | perl -pi -e 's/-P.//gi' >interestgenes.fasta
# removes -* after gene name

srun --cpu_bind=verbose cat interestgenes.fasta | perl -pi -e 's/ .*//gi' | perl -pi -e 's/\n/ /gi' | perl -pi -e 's/>/\n/gi' | sort -V -k 1 | perl -pi -e 's/\n/\n>/gi' | perl -pi -e 's/ /\n/gi' > interest.sorted
# removes ampty lines and lines without gene name 

srun --cpu-bind=verbose perl getlongestCDS.pl interest.sorted
# gets longest CDS for each gene

srun --cpu_bind=verbose perl -pi -e 's/^\n//gi' interest.sorted.longestCDS
# removes empty lines


#cat jarvisi_assembly.scafSeq | perl -pi -e 's/ .*//gi' | perl -pi -e 's/\n/ /gi' | perl -pi -e 's/>/\n/gi' | sort -V -k 1 | perl -pi -e 's/\n/\n>/gi' | perl -pi -e 's/ /\n/gi' > jarvisi_assembly.scafSeq.sorted

