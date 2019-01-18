#!/bin/bash
# 02614 - High-Performance Computing, January 2018
# 
# batch script to run collect on a decidated server in the hpcintro
# queue
#
# Author: Bernd Dammann <bd@cc.dtu.dk>
#
# Note: to get more cores, change the n value below to the
#       number of cores you want to use.  Later on, use the
#       $LSB_DJOB_NUMPROC variable to use this number, e.g. in
#       export OMP_NUM_THREADS=$LSB_DJOB_NUMPROC
#
##---------- Job name
#BSUB -J par_baseline_P1
##-----------out file
#BSUB -oo lsfrun_output_P1.out
##----------error file
#BSUB -eo lsfrun_error_P1.err
##---------- queue name
#BSUB -q hpcintro
##-----------number of cores
#BSUB -n 1
##------------number of cores on the same host---
#BSUB -R "span[hosts=1]"
##------------memory per core-----
#BSUB -R "rusage[mem=1GB]"
## --specify killing of job if it exceeds the memory usage=3GB per core
#BSUB -M 3GB
##-------set wall time [hh:mm]
#BSUB -W 00:06
##BSUB -u your_email_address
### --send notification start--
#BSUB -B
### -- send notification at completion
#BSUB -N


module load studio

# define the executable here
#
EXECUTABLE=parallel_jacobi.exe

# define any command line options for your executable here
# EXECOPTS=

# set some OpenMP variables here
#
# no. of threads
export OMP_NUM_THREADS=$LSB_DJOB_NUMPROC
#
# keep idle threads spinning (needed to monitor idle times!)
export OMP_WAIT_POLICY=active

# thread binding (needed to monitor idle times!)
#export OMP_PROC_BIND=true
#
# if you use a runtime schedule, define it below
# export OMP_SCHEDULE=


# experiment name 
#
JID=${LSB_JOBID}
EXPOUT="$LSB_JOBNAME.${JID}.er"

# start the collect command with the above settings
#collect -o $EXPOUT ./$EXECUTABLE $EXECOPTS

time ./$EXECUTABLE