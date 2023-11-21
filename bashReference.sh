#!/bin/bash
#SBATCH -o job.%j.out
#SBATCH -p 640
#SBATCH -J abacus_work
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
abacus_work=/home/rongshi/abacus/abacus-develop/bin/ABACUS.mpi
IB='-env I_MPI_PIN_DOMAIN omp'
mpirun $IB $abacus_work > $workdir.$SLURM_JOB_ID.out

echo End Time: `date`
