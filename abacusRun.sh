#!/bin/bash
#SBATCH -o job.%j.out
#SBATCH -p 640
#SBATCH -J jg_abacus_work
#SBATCH --nodes=1
##SBATCH -x cpu01
##SBATCH --ntasks=16
#SBATCH --cpus-per-task=48
#SBATCH --ntasks-per-node=1

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo Working directory is $PWD
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu cores.

echo Begin Time: `date`
workdir=$(basename `pwd`)
### * * * Running the tasks * * * ###

abacus_work=/home/linpz/software/abacus-develop/bin_save/ABACUS.mpi-2022.10.19-9727f5
mpirun -n 1 -env OMP_NUM_THREADS=64 $abacus_work  >job.log 2>job.err

echo End Time: `date`
