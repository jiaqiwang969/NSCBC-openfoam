function [A]=fluid_stroh(omega,rho0,K_air,k_x,k_y)
    
A=zeros(2);
       A(1,2)=-1/K_air+(k_x^2+k_y^2)/(rho0*omega^2);
       A(2,1)=rho0*omega^2;