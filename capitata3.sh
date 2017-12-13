#!/bin/bash
#
#SBATCH --job-name="majority rule assignment and synteny"
#SBATCH --time=96:00:00
#SBATCH --mem=10G
#SBATCH --mail-user=julia.raices@ist.ac.at
#SBATCH --mail-type=ALL

export LC_ALL=C

# remove header:
srun --cpu_bind=verbose awk '{if($1 != "Gene") print $0}' dmel-locations.txt > dmel-locations_noheader.txt
# first we have to sort the drosophila file (dumb-dumb)
srun --cpu_bind=verbose sort -k 3 dmel-locations_noheader.txt >dmel-locations.sorted

# majority rules, to get only 1 chr for each scaffold
<<<<<<< HEAD
srun --cpu_bind=verbose cat Dmel_vs_Ccap.blat.sortedbyDB.nonredundant | cut -f 1,10,14 | awk '{print $2, $3, $1}' | perl -pi -e 's/-P.//gi' | sort | perl -pi -e 's/.*lalala.*\n//gi' >Dmel_vs_Ccap.clean
srun --cpu_bind=verbose join -1 1 -2 3 Dmel_vs_Ccap.clean dmel-locations.sorted >Dmel_vs_Ccap.joined
srun --cpu_bind=verbose awk '{print $2, $1, $5, $3}' Dmel_vs_Ccap.joined | sort >Contig_Dmelchrom.inputforbestlocation
=======
srun --cpu_bind=verbose cat Dmel_vs_Ccap.blat.sortedbyDB.nonredundant | cut -f 1,10,14 | awk '{print $2, $3, $1}' | perl -pi -e 's/-P.//gi' | sort | perl -pi -e 's/.*lalala.*\n//gi' | sort -k 2 >Dmel_vs_Ccap.clean
srun --cpu_bind=verbose join  -1 2 -2 3 Dmel_vs_Ccap.clean dmel-locations.sorted >Dmel_vs_Ccap.joined
srun --cpu_bind=verbose awk '{print $2, $1, $5, $3}' Dmel_vs_Ccap.joined | sort -k 1 >Contig_Dmelchrom.inputforbestlocation
>>>>>>> a31fe549af1d22f66e8a7f22941d79ad3a5e4c21

srun --cpu_bind=verbose perl bestlocation.pl Contig_Dmelchrom.inputforbestlocation

# sort best location output:
srun --cpu_bind=verbose sort -k 1 Contig_Dmelchrom.inputforbestlocation.bestlocation >Contig_Dmelchrom.sorted
# final synteny table:
<<<<<<< HEAD
srun --cpu_bind=verbose cat Dmel_vs_Ccap.blat.sortedbyDB.nonredundant | awk '{print $14,$10}' | sort >Dmel_vs_Ccap.sorted2
=======
srun --cpu_bind=verbose cat Dmel_vs_Ccap.blat.sortedbyDB.nonredundant | awk '{print $10,$14}' | sort >Dmel_vs_Ccap.sorted2
>>>>>>> a31fe549af1d22f66e8a7f22941d79ad3a5e4c21
srun --cpu_bind=verbose join Dmel_vs_Ccap.sorted2 Contig_Dmelchrom.sorted | awk '{print $2, $1, $3, $4, $5}' | sort >Dmelchrom_Ccap.sorted3
srun --cpu_bind=verbose join -1 1 -2 3 Dmelchrom_Ccap.sorted3 dmel-locations.sorted > Genes_Ccap_Dmel_Locations.txt

