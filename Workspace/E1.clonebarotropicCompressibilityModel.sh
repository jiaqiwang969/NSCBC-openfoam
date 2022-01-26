#!/bin/bash -l
#SBATCH --ntasks=1
#SBATCH --clusters=zeus
#SBATCH --partition=copyq #Ideally, use copyq for this process. copyq is on zeus.
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
applications=applications/rhoCentralFoamHEM
#3. Define the user directory in the local host and the place where to put the solver
projectUserDir=$(pwd)/projectUserDir
if ! [ -d $projectUserDir/applications ]; then
   mkdir -p $projectUserDir/applications
else
   echo "The directory $projectUserDir/applications already exists."
fi

#4. Copy the solver from the inside of the container to the local file system
appDirInside=src/thermophysicalModels
solverOrg=barotropicCompressibilityModel
solverNew=barotropicCompressibilityModel
if ! [ -d $projectUserDir/$applications/$solverNew ]; then
   #srun -n 1 -N 1 
   singularity exec $theImage bash -c 'cp -r $WM_PROJECT_DIR/'"$appDirInside/$solverOrg $projectUserDir/$applications/$solverNew" 
else
   echo "The directory $projectUserDir/$applications/$solverNew already exists, no new copy has been performed"
fi

#5. Going into the new solver directory
if [ -d $projectUserDir/$applications/$solverNew ]; then
   cd $projectUserDir/$applications/$solverNew
   echo "pwd=$(pwd)"
else
   echo "For some reason, the directory $projectUserDir/$applications/$solverNew, does not exist"
   echo "Exiting"; exit 1
fi

#6. Remove not needed stuff
echo "Removing not needed stuff"
rm -rf *DyMFoam SRFP* *.dep

#7. Rename the source files and replace words inside for the new solver to be: "myPimpleFoam"
#echo "Renaming the source files"
#rename barotropicCompressibilityModel barotropicCompressibilityModel *
#sed -i 's,barotropicCompressibilityModel,barotropicCompressibilityModel,g' *.C
#sed -i 's,barotropicCompressibilityModel,barotropicCompressibilityModel,g' *.H

#8. Modify files inside the Make directory to create the new executable in $FOAM_USER_APPBIN
echo "Adapting files inside the Make directory"
sed -i 's,libbarotropic,libMybarotropic,g' ./Make/files
sed -i 's,FOAM_LIBBIN,FOAM_USER_LIBBIN,g' ./Make/files

#X. Final step
echo "Script done"
