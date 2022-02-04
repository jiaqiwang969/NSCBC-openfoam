#!/bin/bash -l
bash D-cloneadaptCase.sh
bash E-decomposePar.sh
sbatch F2-runFoam-sine.sh
sleep 60s
bash F3-reconstructPar.sh
bash G1-sampling.sh
bash G2-pythonProcessing.sh
