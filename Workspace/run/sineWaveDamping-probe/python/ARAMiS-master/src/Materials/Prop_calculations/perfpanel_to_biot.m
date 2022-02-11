function [phi_perf,rho_perf,young_perf,tort_perf,sigma_perf,LCV_perf,LCT_perf]=perfpanel_to_biot(rho,young,poisson,ls,ds)

% Solid material data
%       rho - density solid
%       young - young modulus solid
%       rhoair
%
%       ls - Hole diam
%       ds - Hole spacing

      phi_perf=(pi*ls^2)/(4*ds^2);
      rho_perf=(1-phi_perf)*rho;
      young_perf=young*((1-phi_perf)^((2*ds-ls)/(0.8*ds)));
      tort_perf=1;
      sigma_perf=32*1.84e-5/(phi_perf*ls^2);
      LCV_perf=ls/2;
      LCT_perf=LCV_perf;
      
lambda=(young_perf*poisson)/((1+poisson)*(1-2*poisson));
mu=(young_perf)/(2*(1+poisson));


C=zeros(6,6);
C(1,:)=[2*mu+lambda lambda lambda 0 0 0];
C(2,:)=[lambda 2*mu+lambda lambda 0 0 0];
C(3,:)=[lambda lambda 2*mu+lambda 0 0 0];
C(4,4)=2*mu;
C(5,5)=2*mu;
C(6,6)=2*mu;