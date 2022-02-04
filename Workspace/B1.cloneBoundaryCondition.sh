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

#3. Define the user directory in the local host and the place where to put the solver
projectUserDir=$(pwd)/projectUserDir
if ! [ -d $projectUserDir/src ]; then
   mkdir -p $projectUserDir/src
else
   echo "The directory $projectUserDir/src already exists."
fi

#4. Copy the boundary condition from the inside of the container to the local file system
appDirInside=src/finiteVolume/fields/fvPatchFields/derived
boundaryOrg=advective
boundaryNew=pressureInletNSCBC
if ! [ -d $projectUserDir/src/$boundaryNew ]; then
   #srun -n 1 -N 1 
   singularity exec $theImage bash -c 'cp -r $WM_PROJECT_DIR/'"$appDirInside/$boundaryOrg $projectUserDir/src/$boundaryNew" 
else
   echo "The directory $projectUserDir/src/$boundaryNew already exists, no new copy has been performed"
fi

#5. Going into the new solver directory
if [ -d $projectUserDir/src/$boundaryNew ]; then
   cd $projectUserDir/src/$boundaryNew
   echo "pwd=$(pwd)"
else
   echo "For some reason, the directory $projectUserDir/src/$boundaryNew, does not exist"
   echo "Exiting"; exit 1
fi

#6. Remove not needed stuff
echo "Removing not needed stuff"
rm -rf  *.dep

#7. Rename the source files and replace words inside for the new solver to be: "myPimpleFoam"
echo "Renaming the source files"
rename advective pressureInletNSCBC *
sed -i 's,advective,pressureInletNSCBC,g' *.C
sed -i 's,advective,pressureInletNSCBC,g' *.H

#8. Modify files inside the Make directory to create the new executable in $FOAM_USER_LIBBIN
echo "Add files inside the Make directory"
rm -rf Make && mkdir -p Make && cd Make
touch files && touch options
echo "pressureInletNSCBCFvPatchFields.C" >> files
echo "LIB = \$(FOAM_USER_LIBBIN)/libpressureInletNSCBC" >> files
echo "EXE_INC = \\" >> options
echo "	-I\$(LIB_SRC)/finiteVolume/lnInclude \\" >> options
echo "       -I\$(LIB_SRC)/meshTools/lnInclude" >> options
echo "EXE_LIBS = \\" >> options
echo "  -lfiniteVolume \\" >> options
echo "  -lmeshTools" >> options


#sed -i 's,advective,pressureInletNSCBC,g' ./Make/files
#sed -i 's,FOAM_LIBBIN,FOAM_USER_LIBBIN,g' ./Make/files

#X. Final step
echo "Script done"
