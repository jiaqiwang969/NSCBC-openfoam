#!/bin/bash -l
#SBATCH --export=NONE
#SBATCH --time=00:05:00
#SBATCH --ntasks=1
#SBATCH --clusters=zeus 
#SBATCH --partition=copyq #Ideally, use the copyq for this processes. copyq is on zeus.
 
#1. Load the necessary modules
#module load singularity
 
#2. Defining the container to be used
theRepo=/lustre/home/acct-medgm/medgm/00-sif
theContainerBaseName=openfoam
theVersion=v2006
theProvider=wjq
theImage=$theRepo/$theContainerBaseName-$theVersion-$theProvider.sif
 
#3. Defining the tutorial and the case directory
tutorialAppDir=compressible/rhoCentralFoam
tutorialName=LadenburgJet60psi
tutorialCase=$tutorialAppDir/$tutorialName

#baseWorkingDir=$MYSCRATCH/OpenFOAM/$USER-$theVersion/workshop/01_usingOpenFOAMContainers/run
baseWorkingDir=$PWD/test_cases
if ! [ -d $baseWorkingDir ]; then
    echo "Creating baseWorkingDir=$baseWorkingDir"
mkdir -p $baseWorkingDir
fi
caseName=$tutorialName
caseDir=$baseWorkingDir/$caseName

#4. Copy the tutorialCase to the workingDir
if ! [ -d $caseDir ]; then
   #Using the internal FOAM_TUTORIALS variable:
   #srun -n 1 -N 1 
   singularity exec $theImage bash -c 'cp -r $FOAM_TUTORIALS/'"$tutorialCase $caseDir"
   #Or using the full internal path:
   #srun -n 1 -N 1 singularity exec $theImage cp -r /opt/OpenFOAM/OpenFOAM-$theVersion/tutorials/$tutorialCase $caseDir
else
   echo "The case=$caseDir already exists, no new copy has been performed"
fi

#5. Going into the case directory
if [ -d $caseDir ]; then
   cd $caseDir
   echo "pwd=$(pwd)"
else
   echo "For some reason, the case=$caseDir, does not exist"
   echo "Exiting"; exit 1
fi

#X. Final step
echo "Script done"
