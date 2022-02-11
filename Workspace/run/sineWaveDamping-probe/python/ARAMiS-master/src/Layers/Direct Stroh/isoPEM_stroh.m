 function [A]=isoPEM_stroh(N,A_hat,P_hat,omega,K_eq_til,k_x,k_y,rho_eq_til,gamma_til,rho_s_til)

A=zeros(8,8);


    A(1,3)=1j*k_x;
    A(1,5)=1/N;

    A(2,3)=1j*k_y;
    A(2,6)=1/N;
    
    A(3,1)=1j*k_x*A_hat/P_hat;
    A(3,2)=1j*k_y*A_hat/P_hat;
    A(3,7)=1/P_hat;
    
    A(4,1)=-1j*k_x*gamma_til;
    A(4,2)=-1j*k_y*gamma_til;
    A(4,8)=(-1/K_eq_til)+(k_x^2+k_y^2)/(omega^2*rho_eq_til);
    
    A(5,1)=-(omega^2)*rho_s_til + (omega^2)*(gamma_til^2)*rho_eq_til - (k_x^2)*(A_hat^2-P_hat^2)/P_hat + N*(k_y^2);
    A(5,2)=k_x*k_y*(N - (A_hat^2/P_hat - A_hat));
    A(5,7)=1j*k_x*(A_hat/P_hat);
    A(5,8)=1j*gamma_til*k_x;
    
    A(6,1)=k_x*k_y*(N - (A_hat^2/P_hat - A_hat));
    A(6,2)=-(omega^2)*rho_s_til + (omega^2)*(gamma_til^2)*rho_eq_til - (k_y^2)*(A_hat^2-P_hat^2)/P_hat + N*(k_x^2);
    A(6,7)=1j*k_y*(A_hat/P_hat);
    A(6,8)=1j*gamma_til*k_y;
    
    A(7,3)=-(omega^2)*rho_s_til;
    A(7,4)=-(omega^2)*rho_eq_til*gamma_til;
    A(7,5)=1j*k_x;
    A(7,6)=1j*k_y;
    
    A(8,3)=(omega^2)*rho_eq_til*gamma_til;
    A(8,4)=(omega^2)*rho_eq_til;
    