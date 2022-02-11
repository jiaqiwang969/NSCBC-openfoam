function [C,E,nu]=closest_iso(Ca)

% Isotropic material closest to a given anisotropic material [Norris, J Mech Mat Struct 1(2) 2006]

% Convert Ca from Voigt to Mehrabadi+Cowin notation
  Ca(1:3,4:6)=sqrt(2).*Ca(1:3,4:6);
  Ca(4:6,1:3)=sqrt(2).*Ca(4:6,1:3);
  Ca(4:6,4:6)=2.*Ca(4:6,4:6);

% matrices defined in paper  
  u=[1/sqrt(3);1/sqrt(3);1/sqrt(3);0;0;0];
  J=u*u.';
  K=eye(size(J))-J;

% Lame constants using minimum log-Euclidean distance  
  kappa=(1/3)*exp(trace(J*logm(Ca)));
  mu=(1/2)*exp((1/5)*trace(K*logm(Ca)));
  lambda=kappa-2*mu/3;

% isotropic stiffness matrix in Voigt notation  
  C=[lambda*ones(3)+2*mu*diag(ones(1,3)) zeros(3);
      zeros(3,3) diag(ones(1,3)*mu)];

% Young modulus, Poisson ratio  
  E=9*kappa*mu/(3*kappa+mu);
  nu=E/(2*mu)-1;


