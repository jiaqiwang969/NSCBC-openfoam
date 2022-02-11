%% Calculation of the Biot equivalent parameters of a perforated solid panel
% Taken from Cameron et al. ()20

function [phi_perf,rho_perf,young_perf,tort_perf,sigma_perf,LCV_perf,LCT_perf]=perf_to_biot(rho,young,ls,ds)

% Solid material data
%       rho - density solid
%       young - young modulus solid
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

end


%  Juan Pablo Parra Martinez
%  jppm@kth.se
%  July,2014