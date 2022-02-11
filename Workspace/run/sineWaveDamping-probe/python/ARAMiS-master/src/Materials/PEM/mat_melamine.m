%% Melamine foam (anisotropic anelastic)
% inputs: omega
% outputs: rho_1, LCV, LCT, tort, phi, sig_i, C_i
 % sig_i and C_i are given in the material coordinate system.

rho_1=9.200;

LCV=240E-06;
LCT=490E-06;
tort=1.2;

phi=0.99;

eigvec=[   0.97000   0.19000   0.12000;
  -0.14000  -0.92000   0.36000;
   0.18000   0.34000   0.92000];
eigvalues=[9800 0 0; 0 10500 0; 0 0 11400];
 
sig_i=diag(diag(inv(eigvec)*(eigvalues*eigvec)));


%% Mechanical parameters
% JC PG CVDK 2014 JAP

% Isotropic reference
E=3e5;
nu=.3;
G=E/(2*(1+nu));

% Scaling parameters

switch 1
    case 1
        X=[1.492535961261368 0.704766632764802 0.566039153724223 0.898183239986565 1.071928174893220 0.877335489340316 1.484325073445238 -1.714726702330278 1.443551392499058].';
    case 2
        X=[1.4925 0.7047 0.5660 0.8981 1.0719 0.8773 1.4843 1.4 1.44].'; % all nu_ij positive
end

% Elastic (static) part of stiffness matrix

E1=X(1)*E;
E2=X(2)*E;
E3=X(3)*E;
G23=X(4)*E/(2*(1+nu));
G31=X(5)*E/(2*(1+nu));
G12=X(6)*E/(2*(1+nu));
nu21=X(7)*nu;
nu13=X(8)*nu;
nu32=X(9)*nu;

d0=[1/E1 1/E2 1/E3 1/G23 1/G31 1/G12]; d1=[-nu21/E2 -nu32/E3 0 0 0]; d2=[-nu13/E1 0 0 0];
% Compliance Matrix
S_0=( diag(d0)+diag(d1,1)+diag(d1,-1)+diag(d2,2)+diag(d2,-2) );

% elastic (static) part of the stiffness matrix in the natural coordinate system
C_0=inv(S_0);



% check if the stiffness matrix is positive-definite
pdef=(all(diag(C_0)) & det(C_0));
if ~pdef, warning('C_0 is not positive-definite!'), end


% Anaelastic properties (fractional derivatives)

beta_an=832.16e3;
b_an=0.29620;
alpha_an=0.33348;


%% Final Hookes Tensor

C_i=C_0.*(1 + b_an*(1i*omega/beta_an)^alpha_an /(1 + (1i*omega/beta_an)^alpha_an));
