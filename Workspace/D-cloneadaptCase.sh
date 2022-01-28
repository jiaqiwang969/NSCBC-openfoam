#!/bin/bash -l
#SBATCH --export=NONE
#SBATCH --time=00:05:00
#SBATCH --ntasks=1
#SBATCH --clusters=zeus
#SBATCH --partition=copyq #Ideally, use the copyq for this process. copyq is on zeus.
 
#1. Load the necessary modules
#module load singularity
 
#2. Defining the container to be used
theRepo=/lustre/home/acct-medgm/medgm/00-sif
theContainerBaseName=openfoam
theVersion=7
theProvider=pawsey
theImage=$theRepo/$theContainerBaseName-$theVersion-$theProvider.sif
 
#3. Defining the case directory
caseName=sod_shock_tube

baseWorkingDir=$PWD/run
caseDir=$baseWorkingDir/$caseName
mkdir -p $baseWorkingDir
cp -rf $PWD/test_cases/$caseName $baseWorkingDir
rm -rf $baseWorkingDir/$caseName/0
cp -rf $baseWorkingDir/$caseName/0_org $baseWorkingDir/$caseName/0

#4. Going into the case directory
if [ -d $caseDir ]; then
   cd $caseDir
   echo "pwd=$(pwd)"
else
   echo "For some reason, the case=$caseDir, does not exist"
   echo "Exiting"; exit 1
fi

#5. Defining OpenFOAM controlDict settings for Pawsey Best Practices
##5.1 Replacing writeFormat, runTimeModifiable and purgeRight settings
foam_writeFormat="ascii"
sed -i 's,^writeFormat.*,writeFormat    '"$foam_writeFormat"';,' ./system/controlDict
foam_runTimeModifiable="true"
sed -i 's,^runTimeModifiable.*,runTimeModifiable    '"$foam_runTimeModifiable"';,' ./system/controlDict
foam_purgeWrite=0
sed -i 's,^purgeWrite.*,purgeWrite    '"$foam_purgeWrite"';,' ./system/controlDict

##5.2 Defining the use of collated fileHandler of output results 
#echo "OptimisationSwitches" >> ./system/controlDict#echo "{" >> ./system/controlDict
#echo "{" >> ./system/controlDict
#echo "   fileHandler uncollated;" >> ./system/controlDict
#echo "}" >> ./system/controlDict

#X. Final step
echo "Script done"
