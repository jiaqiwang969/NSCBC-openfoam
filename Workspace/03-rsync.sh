#!/bin/bash -l
rsync -avz --exclude 'processor*' medgm@login.hpc.sjtu.edu.cn:/lustre/home/acct-medgm/medgm/05-NSCBC/Workspace/run ./
