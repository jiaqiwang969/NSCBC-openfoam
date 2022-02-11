%   AIR_PROPERTIES_MAINE
%       contains the properties of air, as they are displayed by the
%       default configuation of Maine3A
%   Created by C?me OLIVIER on 31/03/2012
%
%   Copyright 2012 LAUM UMR CNRS 6613 (France)
%   Part of the ACOUPORONUM project (Matlab version)
%   Contact olivier.dazel@univ-lemans.fr
%   All rights reserved



% %% Constants
% T_0=20;                                     %[?C]
% P_0=0.10132e6;                              %[Pa]
% gamma=1.400;                                %[1]
% mmol=.29e-1;                                %[kg.mol^-1]
% mu_0=.184e-4; % Dynamic viscosity           %(kg/m/s)
% NPR=0.710;
% lambda_0=0.0262;                              %[W.m^-1.K^-1]
%
% %% Air properties
% rho_0=1.204;                                %[kg.m^-3]
% c_0=343.25946;                              %[m.s^-1]
%
% K_0=c_0^2*rho_0;
% Z_0=rho_0*c_0;
%
% C_p=1006;
% C_v=C_p/gamma;
%
% nu_0=mu_0/rho_0;
% nu_prime_0=nu_0/NPR;


T_0= 20;
P_0= 101320;
gamma= 1.400000000000000;
mmol= 0.029000000000000;
mu_0= 1.840000000000000e-05;
NPR= 0.710000000000000;
lambda= 0.026200000000000;
rho_0= 1.204000000000000;
c_0= 3.432594600000000e+02;
K_0= 1.418637764829079e+05;
Z_0= 4.132843898400000e+02;
C_p= 1006;
C_v= 7.185714285714287e+02;
nu_0= 1.528239202657807e-05;
nu_prime_0= 2.152449581208180e-05;

K=K_0;
rho=rho_0;
