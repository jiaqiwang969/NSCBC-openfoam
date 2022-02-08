#!/bin/bash -l
#SBATCH --job-name=sineWaveDamping
#SBATCH --partition=small
#SBATCH -n 4
#SBATCH --ntasks-per-node=40
#SBATCH --output=%j.out
#SBATCH --error=%j.err

ulimit -s unlimited
ulimit -l unlimited


#1. Load the necessary modules
module load openmpi 

#2. Defining the container to be used
theRepo=/lustre/home/acct-medgm/medgm/00-sif
theContainerBaseName=openfoam
theVersion=v2006
theProvider=wjq
theImage=$theRepo/$theContainerBaseName-$theVersion-$theProvider.sif
 
#3. Defining the case directory
#baseWorkingDir=$MYSCRATCH/OpenFOAM/$USER-$theVersion/run
#baseWorkingDir=$MYSCRATCH/OpenFOAM/$USER-$theVersion/workshop/01_usingOpenFOAMContainers/run
baseWorkingDir=$SLURM_SUBMIT_DIR/run
caseName=sineWaveDamping
caseDir=$baseWorkingDir/$caseName

#4. Going into the case and creating the logs dir
if [ -d $caseDir ]; then
   cd $caseDir
   echo "pwd=$(pwd)"
else
   echo "For some reason, the case=$caseDir, does not exist"
   echo "Exiting"; exit 1
fi
logsDir=./logs/run
if ! [ -d $logsDir ]; then
   mkdir -p $logsDir
fi

#5. Reading OpenFOAM decomposeParDict settings
foam_numberOfSubdomains=$(grep "^numberOfSubdomains" ./system/decomposeParDict | tr -dc '0-9')

#6. Defining the ioRanks for collating I/O
# groups of 2 for this exercise (please read our documentation for the recommendations for production runs)
#export FOAM_IORANKS='(0 40 80)'

#7. Checking if the number of tasks coincide with the number of subdomains

#8. Defining OpenFOAM controlDict settings for this run
foam_startFrom=startTime
#foam_startFrom=latestTime
foam_startTime=0
#foam_startTime=15
foam_endTime=0.0112
#foam_endTime=30
foam_writeInterval=1.0e-4
foam_purgeWrite=0
foam_deltaT=2.0e-6


#9. Changing OpenFOAM controlDict settings
sed -i 's,^startFrom.*,startFrom    '"$foam_startFrom"';,' system/controlDict
sed -i 's,^startTime.*,startTime    '"$foam_startTime"';,' system/controlDict
sed -i 's,^endTime.*,endTime    '"$foam_endTime"';,' system/controlDict
sed -i 's,^writeInterval.*,writeInterval    '"$foam_writeInterval"';,' system/controlDict
sed -i 's,^purgeWrite.*,purgeWrite    '"$foam_purgeWrite"';,' system/controlDict
sed -i 's,^deltaT.*,deltaT     '"$foam_deltaT"';,' system/controlDict


#10. Defining the solver
theSolver=rhoPimpleFoam

#11. Defining the projectUserDir to be mounted into the path of the internal WM_PROJECT_USER_DIR
projectUserDir=$SLURM_SUBMIT_DIR/projectUserDir

#12. Execute the case 
echo "About to execute the case"


srun --mpi=pmi2 singularity exec -B $projectUserDir:/home/ofuser/OpenFOAM/ofuser-$theVersion $theImage $theSolver -parallel 2>&1 | tee $logsDir/log.$theSolver.$SLURM_JOBID
echo "Execution finished"

#X. Final step
echo "Script done"
