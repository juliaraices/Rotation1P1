#!/bin/bash
#
#SBATCH --job-name="majority rule assignment and synteny"
#SBATCH --time=96:00:00
#SBATCH --mem=10G
#SBATCH --mail-user=julia.raices@ist.ac.at
#SBATCH --mail-type=ALL

export LC_ALL=C

# majority rules, to get only 1 chr for each scaffold
srun --cpu_bind=verbose cat Dmel_Ccap_onlyhits.BLAST | cut -f 1,2,4 | awk '{print $2, $1, $3}' >Dmel_Ccap.BLAST.clean
srun --cpu_bind=verbose join -1 1 -2 3 Dmel_Ccap.BLAST.clean dmel-locations.sorted >Dmel_Ccap.BLAST.joined
srun --cpu_bind=verbose awk '{print $2, $1, $5, $3}' Dmel_Ccap.BLAST.joined | sort >BLAST_Dmelchrom.inputforbestlocation

srun --cpu_bind=verbose perl bestlocation.pl BLAST_Dmelchrom.inputforbestlocation

# sort best location output:
srun --cpu_bind=verbose sort -k 1 BLAST_Dmelchrom.inputforbestlocation.bestlocation >BLAST_Dmelchrom.sorted
# final synteny table:
srun --cpu_bind=verbose cat Dmel_Ccap_onlyhits.BLAST | awk '{print $1,$2}' | sort >Dmel_Ccap.BLAST.sorted2
srun --cpu_bind=verbose join Dmel_Ccap.BLAST.sorted2 BLAST_Dmelchrom.sorted | awk '{print $2, $1, $3, $4, $5}' | sort >BLAST_Dmelchrom_Ccap.sorted3
srun --cpu_bind=verbose join -1 1 -2 3 BLAST_Dmelchrom_Ccap.sorted3 dmel-locations.sorted > BLAST_Ccap_Dmel_Locations.txt

