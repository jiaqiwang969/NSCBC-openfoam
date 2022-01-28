#!/bin/bash -l
#SBATCH --job-name=sod_shock_tube
#SBATCH --partition=debug
#SBATCH -n 4
#SBATCH --ntasks-per-node=40
#SBATCH --output=%j.out
#SBATCH --error=%j.err



#1. Defining the container to be used
theRepo=/lustre/home/acct-medgm/medgm/00-sif
theContainerBaseName=openfoam
theVersion=7
theProvider=pawsey
theImage=$theRepo/$theContainerBaseName-$theVersion-$theProvider.sif
 
baseWorkingDir=$PWD/run
caseName=sod_shock_tube
caseDir=$baseWorkingDir/$caseName

#2. Going into the case and creating the logs dir
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

#3. Reading OpenFOAM decomposeParDict settings
foam_numberOfSubdomains=$(grep "^numberOfSubdomains" ./system/decomposeParDict | tr -dc '0-9')

echo "reconstructPar"
singularity exec -B $projectUserDir:/home/ofuser/OpenFOAM/ofuser-$theVersion $theImage reconstructPar 2>&1 | tee $logsDir/log.reconstructPar.$SLURM_JOBID
echo "Execution finished"

#X. Final step
echo "Script done"
