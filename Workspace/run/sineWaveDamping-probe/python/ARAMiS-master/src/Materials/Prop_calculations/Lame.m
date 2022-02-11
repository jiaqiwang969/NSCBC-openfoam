%% Function for the calculations of the Lame coefficients for an isotropic material
% (no damping included as it depends on elastic or anelastic models)

    
    function [Lame1,Lame2]=Lame(E,poisson)
    
    Lame1=(E*poisson)/((1+poisson)*(1-2*poisson));
    Lame2=(E)/(2*(1+poisson));
    
    end
 
%  Juan Pablo Parra Martinez
%  jppm@kth.se
%  July,2014