function [A]=isosolid_stroh(omega,rho,k_x,k_y,lambda,mu)
    

    A=zeros(6,6);
    
    A(1,3)= 1j*k_x;
    A(1,4)= 1/mu;
    
    A(2,3)= 1j*k_y;
    A(2,5)= 1/mu;
    
    A(3,1)=1j* (lambda/(lambda+2*mu)) * k_x;
    A(3,2)=1j* (lambda/(lambda+2*mu)) * k_y;    
    A(3,6)= 1/(lambda+2*mu);
    
    A(4,1)= -rho*omega^2 + k_x^2*((lambda+2*mu)^2 - lambda^2)/(lambda+2*mu)+ k_x*k_y*mu;
    A(4,2)= k_x*k_y*(lambda*(lambda + mu)-lambda^2)/(lambda+2*mu) + k_y^2*mu;
    A(4,6)= 1j*k_x*lambda/(lambda +2*mu);
    
    A(5,1)= k_x*k_y*(lambda*(lambda + mu)-lambda^2)/(lambda+2*mu) + k_x^2*mu;
    A(5,2)= -rho*omega^2 + k_y^2*((lambda+2*mu)^2 - lambda^2)/(lambda+2*mu)+ k_x*k_y*mu;
    A(5,6)= 1j*k_y*lambda/(lambda +2*mu);
    
    A(6,3)=-omega^2 * rho;
    A(6,4)=1j*k_x;
    A(6,5)=1j*k_y;