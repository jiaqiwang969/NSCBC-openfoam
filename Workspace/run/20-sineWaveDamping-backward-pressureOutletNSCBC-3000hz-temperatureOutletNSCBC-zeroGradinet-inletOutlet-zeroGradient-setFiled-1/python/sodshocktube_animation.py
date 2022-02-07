# Exact Riemann solver for SOD problem. 
# 
# Adapted from the listing given in Toro[1] and in http://www.quarkgluon.com/hllc-based-riemann-solver-and-exact-solution/ 
# 
# [1] - Toro, E.F., Riemann Solvers and Numerical Methods for Fluid Dynamics: A Practical Introduction, 3rd Ed., Springer
# 

import sys
from math import sqrt
import numpy as np

    

#exact solution plot
import matplotlib.pyplot as plt




for time in np.linspace(0.0022,0.0112,16):
    #Read in openfoam solution
    print(round(time,4))
    filename='../postProcessing/sampleDict/{}/data_T_mag(U)_p.xy'.format(round(time,4))
    #print(filename)
    cols = np.loadtxt(filename)
    ##pressure plot
    plt.figure(figsize=(10,6))
    plt.plot(cols[:,0],cols[:,3],c='red',label='pre - openfoam')
    plt.plot([-1.25,1.25],[101320,101320],c='blue',label='base')
    plt.xlim([-1.25,1.25])
    plt.ylim([101260,101380])
    plt.legend(loc=0)
    plt.title('shockTube model-p: T={}'.format("%.4f" % time))
    plt.grid()
    plt.savefig('p-{}.png'.format("%.4f" % time), dpi=100)

for time in np.linspace(0.0022,0.0112,16):
    #Read in openfoam solution
    print(round(time,4))
    filename='../postProcessing/sampleDict/{}/data_T_mag(U)_p.xy'.format(round(time,4))
    #print(filename)
    cols = np.loadtxt(filename)
    ##pressure plot
    plt.figure(figsize=(10,6))
    plt.plot(cols[:,0],cols[:,2],c='red',label='pre - openfoam')
    plt.plot([-1.25,1.25],[0,0])
    plt.xlim([-1.25,1.25])
    plt.ylim([-5,5])
    plt.legend(loc=0)
    plt.title('shockTube model-U: T={}'.format("%.4f" % time))
    plt.grid()
    plt.savefig('U-{}.png'.format("%.4f" % time), dpi=100)

for time in np.linspace(0.0022,0.0112,16):
    #Read in openfoam solution
    print(round(time,4))
    filename='../postProcessing/sampleDict/{}/data_T_mag(U)_p.xy'.format(round(time,4))
    #print(filename)
    cols = np.loadtxt(filename)
    ##pressure plot
    plt.figure(figsize=(10,6))
    plt.plot(cols[:,0],cols[:,1],c='red',label='pre - openfoam')
    plt.xlim([-1.25,1.25])
    plt.ylim([295,305])
    plt.legend(loc=0)
    plt.title('shockTube model-T: T={}'.format("%.4f" % time))
    plt.grid()
    plt.savefig('T-{}.png'.format("%.4f" % time), dpi=100)
