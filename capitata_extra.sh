#!/bin/bash
#
#SBATCH --job-name="BLAST C capitata/Dmel" # job name
#SBATCH --time=96:00:00 #maximum runtime
#SBATCH --mem=50G #maximum memmory allocation
#SBATCH --mail-user=julia.raices@ist.ac.at #send e-mail to user at end or error
#SBATCH --mail-type=ALL
#SBATCH --gres=mathematica:0 #set (resource) mathematica specification to 0
#SBATCH -c 5 # number of CPU cores to use within one node for OpenMP jobs

export LC_ALL=C

#make data base from C capitata
srun --cpu_bind=verbose makeblastdb -in ../Ccap01172013-genome.fa -dbtype 'nucl' -out CcapDB

# run blast for interest genes and Ccapitata scaffolds
srun --cpu_bind=verbose tblastx -db CcapDB -query interest.sorted.longestCDS -outfmt 7 -max_target_seqs 1 -num_threads 16 -evalue 1e-10 -max_hsps 1 -out Dmel_Ccap.BLAST

# get only the hits and ignore were there were no hits
srun --cpu_bind=verbose grep -v "#" Dmel_Ccap.BLAST | sort -k 2 >Dmel_Ccap_onlyhits.BLAST
#srun --cpu_bind=verbose cat Dmel_Ccap_onlyhits.BLAST | awk '{print $1, $2}' | sort | uniq -c >countsDmelCcap.txt

