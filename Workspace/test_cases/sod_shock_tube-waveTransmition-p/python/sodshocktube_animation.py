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




for time in np.linspace(0.0001,0.0030,15):
    #Read in openfoam solution
    print(round(time,4))
    filename='../postProcessing/sampleDict/{}/data_T_mag(U)_p.xy'.format(round(time,4))
    #print(filename)
    cols = np.loadtxt(filename)
    ##pressure plot
    plt.figure(figsize=(10,6))
    plt.plot(cols[:,0],cols[:,3],c='red',label='pre - openfoam')
    plt.xlim([-0.1,1.1])
    plt.ylim([95000,125000])
    plt.legend(loc=0)
    plt.title('shockTube model: T={}'.format("%.4f" % time))
    plt.grid()
    plt.savefig('{}.png'.format("%.4f" % time), dpi=100)

