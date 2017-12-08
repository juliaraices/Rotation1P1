#!/bin/bash
#
#SBATCH --job-name="transcriptome assembly" # job name
#SBATCH --time=96:00:00 #maximum runtime
#SBATCH --mem=50G #maximum memmory allocation
#SBATCH --mail-user=julia.raices@ist.ac.at #send e-mail to user at end or error
#SBATCH --mail-type=ALL
#SBATCH --gres=mathematica:0 #set (resource) mathematica specification to 0
#SBATCH -c 5 # number of CPU cores to use within one node for OpenMP jobs
#SBATCH --output=SOAPdenovo2.%J.out
#SBATCH --error=SOAPdenovo2.%J.err


module load SOAPdenovoTrans
# assemble scaffolds
srun --cpu_bind=verbose SOAPdenovo-Trans-31mer all -s jarvisi_soap.txt -K 31 -o jarvisi_assembly -p 16 # run all binaries with srun (srun will have a list of CPUs which were allocated to your job)
