#!/bin/sh
#
#These commands set up the Grid Environment for your job:
#PBS -N soc-b
#PBS -o jobrun.out
#PBS -e jobrun.err
#PBS -l nodes=2:ppn=24
#PBS -l walltime=120:00:00
 
# PATH
mpirun=/home/soft/intel/compilers_and_libraries_2017.4.196/linux/mpi/intel64/bin/mpirun
vasp='/storage1/home/lbx/soft/anaconda3/bin/python'

ncpu=`cat $PBS_NODEFILE | wc -l`
ulimit -s unlimited
 
cd $PBS_O_WORKDIR

# write start time
echo Job started at `date` >begin_time

$mpirun -machinefile $PBS_NODEFILE -np $ncpu $vasp i.py> PTOUT 2> err

# write finish time
echo Job finished at `date`>end_time
