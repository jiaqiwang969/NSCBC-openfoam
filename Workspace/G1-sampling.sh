#!/bin/bash -l
#SBATCH --ntasks=1
#SBATCH --mem=4G
#SBATCH --ntasks-per-node=28
#SBATCH --clusters=zeus
#SBATCH --partition=workq
#SBATCH --time=0:10:00
#SBATCH --export=none

#1. Load the necessary modules
#module load singularity
 
#2. Defining the container to be used
theRepo=/lustre/home/acct-medgm/medgm/00-sif
theContainerBaseName=openfoam
theVersion=7
theProvider=pawsey
theImage=$theRepo/$theContainerBaseName-$theVersion-$theProvider.sif
 
#3. Defining the case directory
#baseWorkingDir=$MYSCRATCH/OpenFOAM/$USER-$theVersion/run
#baseWorkingDir=$MYSCRATCH/OpenFOAM/$USER-$theVersion/workshop/01_usingOpenFOAMContainers/run
baseWorkingDir=$(pwd)/run
caseName=sod_shock_tube
caseDir=$baseWorkingDir/$caseName

#4. Going into the case and creating the logs directory
if [ -d $caseDir ]; then
   cd $caseDir
   echo "pwd=$(pwd)"
else
   echo "For some reason, the case=$caseDir, does not exist"
   echo "Exiting"; exit 1
fi
logsDir=./logs/pre
if ! [ -d $logsDir ]; then
   mkdir -p $logsDir
fi




echo "Sampling"
#srun -n 1 -N 1 
singularity exec $theImage postProcess -func 'mag(U)'  2>&1 | tee $logsDir/log.decomposePar.$SLURM_JOBID
singularity exec $theImage postProcess -func 'components(U)'  2>&1 | tee $logsDir/log.decomposePar.$SLURM_JOBID
singularity exec $theImage postProcess -func sampleDict  2>&1 | tee $logsDir/log.decomposePar.$SLURM_JOBID




#X. Final step
echo "Script done"

