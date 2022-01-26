#!/bin/bash -l
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=28
#SBATCH --clusters=zeus
#SBATCH --partition=workq
#SBATCH --time=0:05:00
#SBATCH --export=none

#1. Load the necessary modules
#module load singularity

#2. Defining the container to be used
theRepo=/lustre/home/acct-medgm/medgm/00-sif
theContainerBaseName=openfoam
theVersion=v2006
theProvider=wjq
theImage=$theRepo/$theContainerBaseName-$theVersion-$theProvider.sif

#3. Going into the new solver directory and creating the logs directory
#projectUserDir=$MYGROUP/OpenFOAM/$USER-$theVersion/workshop/02_runningUsersOwnTools
projectUserDir=$(pwd)/projectUserDir
solverNew=MytwoPhaseMixtureThermo
applications=applications/rhoCentralFoamHEM
if [ -d $projectUserDir/$applications/$solverNew ]; then
   cd $projectUserDir/$applications/$solverNew
   echo "pwd=$(pwd)"
else
   echo "For some reason, the directory $projectUserDir/$applications/$solverNew, does not exist"
   echo "Exiting"; exit 1
fi
logsDir=./logs/compile
if ! [ -d $logsDir ]; then
   mkdir -p $logsDir
fi


#4. Use container's "wclean" to clean previously existing compilation 
echo "Cleaning previous compilation"
#srun -n 1 -N 1
singularity exec -B $projectUserDir:/home/ofuser/OpenFOAM/ofuser-$theVersion $theImage wclean 2>&1 | tee $logsDir/wclean.$SLURM_JOBID

#5. Use container's "wmake" (and compiler) to compile your own tool
echo "Compiling MytwoPhaseMixtureThermo.sh"
#srun -n 1 -N 1 
singularity exec -B $projectUserDir:/home/ofuser/OpenFOAM/ofuser-$theVersion $theImage wmake 2>&1 | tee $logsDir/wmake.$SLURM_JOBID


#X. Final step
echo "Script done"