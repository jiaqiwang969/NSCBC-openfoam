#!/bin/bash -l
bash D-cloneadaptCase-sineWaveDamping.sh
bash E-decomposePar-sineWaveDamping.sh
sbatch F2-runFoam-sineWaveDamping.sh
sleep 60s #if detect "Script done" in .out
bash F3-reconstructPar-sineWaveDamping.sh
bash G1-sampling-sineWaveDamping.sh
bash G2-pythonProcessing-sineWaveDamping.sh
