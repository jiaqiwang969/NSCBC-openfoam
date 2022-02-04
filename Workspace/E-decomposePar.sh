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
theVersion=v2006
theProvider=wjq
theImage=$theRepo/$theContainerBaseName-$theVersion-$theProvider.sif
 
#3. Defining the case directory
#baseWorkingDir=$MYSCRATCH/OpenFOAM/$USER-$theVersion/run
#baseWorkingDir=$MYSCRATCH/OpenFOAM/$USER-$theVersion/workshop/01_usingOpenFOAMContainers/run
baseWorkingDir=$(pwd)/run
caseName=sineWaveDamping
caseDir=$baseWorkingDir/$caseName


#3. Defining the projectUserDir to be mounted into the path of the internal WM_PROJECT_USER_DIR
projectUserDir=$PWD/projectUserDir

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

#5. Reading the OpenFOAM decomposeParDict settings
echo "Reading decomposeParDict"
foam_numberOfSubdomains=$(grep "^numberOfSubdomains" ./system/decomposeParDict | tr -dc '0-9')

#6. Defining the ioRanks for collating I/O
# groups of 2 for this exercise (please read our documentation for the recommendations for production runs)
#export FOAM_IORANKS='(0 40 80)'


#6. clean files
echo "Cleaning files"
singularity exec -B $projectUserDir:/home/ofuser/OpenFOAM/ofuser-$theVersion $theImage foamCleanTutorials 2>&1 | tee $logsDir/log.foamCleanTutorials.$SLURM_JOBID

#7. Perform all preprocessing OpenFOAM steps up to decomposition
echo "Executing blockMesh"
#srun -n 1 -N 1 
singularity exec -B $projectUserDir:/home/ofuser/OpenFOAM/ofuser-$theVersion $theImage blockMesh 2>&1 | tee $logsDir/log.blockMesh.$SLURM_JOBID


#mkdir processor{0..$foam_numberOfSubdomains}

echo "setFeilds"
#srun -n 1 -N 1
singularity exec -B $projectUserDir:/home/ofuser/OpenFOAM/ofuser-$theVersion $theImage setFields 2>&1 | tee $logsDir/log.setFields.$SLURM_JOBID

echo "Executing decomposePar"
#srun -n 1 -N 1 
singularity exec -B $projectUserDir:/home/ofuser/OpenFOAM/ofuser-$theVersion $theImage decomposePar -cellDist -force 2>&1 | tee $logsDir/log.decomposePar.$SLURM_JOBID



#X. Final step
echo "Script done"

