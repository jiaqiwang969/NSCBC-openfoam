 function [A]=PEM_stroh(C,omega,K_eq_til,k_x,k_y,rho_eq_til,gamma_til,rho_s_til)
       
    NbreDonde(1,1)=k_x;
    NbreDonde(2,1)=k_y;
    
    RHO_eq_til=rho_eq_til;
    GAMMA_til=gamma_til;
    RHO_s_til=rho_s_til;

    RHO_A=RHO_eq_til*GAMMA_til;
    RHO_B=RHO_eq_til;
    RHO_C=RHO_s_til;
    RHO_D=RHO_eq_til*GAMMA_til;
    
%     RHO_A = inv(phi)*rho_12_til - rho_22_til.*inv(phi)*(1-phi) ;
%     RHO_B = inv(phi^2)*rho_22_til;
%     RHO_C = rho_11_til - rho_12_til.*inv(phi)*(1-phi) ;
%     RHO_D = inv(phi)*rho_12_til ;    
    
%     RHO_A=RHO_A*eye(3);
%     RHO_B=RHO_B*eye(3);
%     RHO_C=RHO_C*eye(3);
%     RHO_D=RHO_D*eye(3);
    
%% UNIT matrixes T_ut T_us T_sig

T_us=zeros(3,8);
    T_us(1,1)=1;
    T_us(2,2)=1;
    T_us(3,3)=1;

T_ut=zeros(3,8);
    T_ut(1:2,1:3)= - RHO_B(1:2,1:2) \ RHO_A(1:2,:);
    T_ut(1:2,4)= - RHO_B(1:2,1:2) \ RHO_B(1:2,3);
    T_ut(1:2,8)= - RHO_B(1:2,1:2)\(1j*NbreDonde/(omega^2));
    T_ut(3,4)=1;

T_sig=zeros(3,8);
    T_sig(1,7)=1;
    T_sig(2,6)=1;
    T_sig(3,5)=1;

%% Step matrixes A_step B_step Ap_step Bp_step Bpp_step
    
    
A_step=zeros(6,3);
    A_step(1,1) = - 1j*k_x;
    A_step(2,2) = - 1j*k_y;
    A_step(4,3) = - 1j*k_y;
    A_step(5,3) = - 1j*k_x;
    A_step(6,1) = - 1j*k_y;
    A_step(6,2) = - 1j*k_x;

B_step=zeros(6,3);
    B_step(3,3) = 1;
    B_step(4,2) = 1;
    B_step(5,1) = 1;

Ap_step=zeros(3,6);
    Ap_step(1,1) = -1j*k_x;
    Ap_step(1,6) = -1j*k_y;
    Ap_step(2,2) = -1j*k_y;
    Ap_step(2,6) = -1j*k_x;
    Ap_step(3,4) = -1j*k_y;
    Ap_step(3,5) = -1j*k_x;
       
Bp_step=zeros(3,6);
    Bp_step(1,5) = 1;
    Bp_step(2,4) = 1;
    Bp_step(3,3) = 1;
    
%%                      TRANSFER MATRIX
    
A=zeros(8,8);

    A(1:3,:)=(C(3:5,1:6)*B_step)\(T_sig - C(3:5,1:6)*A_step*T_us);
    
    A(4,:)= [0 0 0 0 0 0 0 -1/K_eq_til] + 1j*k_x*T_ut(1,:) + 1j*k_y*T_ut(2,:);
    
    A(7:-1:5,:)=Bp_step(:,3:5)\( - (omega^2)*RHO_C*T_us - (omega^2)*RHO_D*T_ut - Ap_step*C*(A_step*T_us + B_step*A(1:3,:)));
    
    A(8,:)=   (omega^2)*RHO_A(3,1:3)*T_us + (omega^2)*RHO_B(3,1:3)*T_ut ;

    
    

