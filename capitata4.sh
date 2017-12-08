#!/bin/bash
#
#SBATCH --job-name="majority rule assignment and synteny"
#SBATCH --time=96:00:00
#SBATCH --mem=10G
#SBATCH --mail-user=julia.raices@ist.ac.at
#SBATCH --mail-type=ALL

export LC_ALL=C

# remove header:
awk '{if($1 != "Gene") print $0}' dmel-locations.txt > dmel-locations_noheader.txt
# first we have to sort the drosophila file (dumb-dumb)
sort -k 3 dmel-locations_noheader.txt >dmel-locations.sorted

# majority rules, to get only 1 chr for each scaffold
cat Dmel_vs_Ccap.blat.sortedbyDB.nonredundant | cut -f 1,10,14 | awk '{print $2, $3, $1}' | perl -pi -e 's/-P.//gi' | sort | perl -pi -e 's/.*lalala.*\n//gi' | sort -k 2 >Dmel_vs_Ccap.clean
join  -1 2 -2 3 Dmel_vs_Ccap.clean dmel-locations.sorted >Dmel_vs_Ccap.joined
awk '{print $2, $1, $4, $3}' Dmel_vs_Ccap.joined | sort > Contig_Dmelchrom.inputforbestlocation

perl bestlocation.pl Contig_Dmelchrom.inputforbestlocation

# final synteny table:
cat Dmel_vs_Ccap.blat.sortedbyDB.nonredundant | awk '{print $14,$10}' | sort |join /dev/stdin Contig_Dmelchrom.inputforbestlocation.bestlocation | awk '{print $2, $1, $3, $4, $5}' | sort | join dmel-locations_noheader.txt > Genes_Ccap_Dmel_Locations.txt

