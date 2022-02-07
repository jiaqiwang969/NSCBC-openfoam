#!/bin/bash

foamCleanTutorials
blockMesh
#checkMesh
rm -rf 0
cp -r 0_org/ 0
setFields

#OF6
#sonicFoam | tee log.solver

#OF7
rhoPimpleFoam | tee log.solver

postProcess -func 'mag(U)' 
postProcess -func 'components(U)' 
postProcess -func sampleDict
