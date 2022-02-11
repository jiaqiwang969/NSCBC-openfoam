function [A]=anisolid_stroh(omega,rho,k_x,k_y,C)
   %% UNIT matrixes T_us T_sig

T_us=zeros(3,6);
    T_us(1,1)=1;
    T_us(2,2)=1;
    T_us(3,3)=1;

T_sig=zeros(3,6);
    T_sig(1,6)=1;
    T_sig(2,5)=1;
    T_sig(3,4)=1;

%% Step matrixes A_step B_step Ap_step Bp_step Bpp_step
    
    
A_step=zeros(6,3);
    A_step(1,1) = - 1j*k_x;
    A_step(2,2) = - 1j*k_y;
    A_step(4,3) = - 1j*k_y/2;
    A_step(5,3) = - 1j*k_x/2;
    A_step(6,1) = - 1j*k_y/2;
    A_step(6,2) = - 1j*k_x/2;

B_step=zeros(6,3);
    B_step(3,3) = 1;
    B_step(4,2) = 1/2;
    B_step(5,1) = 1/2;

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

A=zeros(6,6);

    A(1:3,:)=(C(3:5,:)*B_step)\(T_sig - C(3:5,:)*A_step*T_us);

    A(6:-1:4,:)=Bp_step(:,3:5)\( - (omega^2).*rho*T_us - Ap_step*C*(A_step*T_us + B_step*A(1:3,:)));
