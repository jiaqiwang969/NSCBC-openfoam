function [M_0,M_1,M_2,A_x,A_y,A_z,m_layer]=pem_adsfwaeflayer(rho_eq_til,gamma_til,rho_s_til,K_eq_til,C,omega)


%% equations discretization

%        /    u^s_x    \
%  {u} = |    u^s_y    |
%        |    u^s_z    |
%        |    u^t_z    |
%        | Sigma^s_zz  |
%        | Sigma^s_yz  |
%        | Sigma^s_xz  |
%        |      p      |
%        |  =========
%        |    u^t_x    |
%        |    u^t_y    |
%        | Sigma^s_xx  |
%        | Sigma^s_yy  |
%        \ Sigma^s_xy  /


    % FORM    [ (jw)M + A_0 - jk_x*A_x - jk_y*A_y + A_z(d/dz) ] u = 0
    
m_layer=4;
rho_comp=rho_eq_til*gamma_til;
   
% the terms have been calculated for velocity and pressure
% then an adaption has been done to transform the state vector
% as displacement and pressure From M_v to M, A_x_v to A_x,...
%
% v = j*w*u



% terms on (jw)
 M_v=zeros(13,13);
    M_v(1,8)=1;
    
    M_v(2:4,1:3)  =rho_comp;
    M_v(2:4,4)    =rho_eq_til(1:3,3);
    M_v(2:4,9:10) =rho_eq_til(1:3,1:2);
    
    M_v(5:7,1:3)  =-rho_s_til;
    M_v(5:7,4)    =-rho_comp(1:3,3);
    M_v(5:7,9:10) =-rho_comp(1:3,1:2);
    
    M_v(8,11)     =-1;
    M_v(9,12)     =-1;
    M_v(10,5)     =-1;
    M_v(11,6)     =-1;
    M_v(12,7)     =-1;
    M_v(13,13)    =-1;

M_0=zeros(13,13);    
    
M_1=[M_v(:,1:4).*1j*omega M_v(:,5:8) M_v(:,9:10).*1j*omega M_v(:,11:13)];

M_2=zeros(13,13);  

% terms on (-jk_x)
 A_x_v=zeros(13,13);
    A_x_v(1,9)    =K_eq_til;
    
    A_x_v(2,8)    =1;
    
    A_x_v(5,11)   =1;
    A_x_v(6,13)   =1;
    A_x_v(7,7)    =1;
    
    A_x_v(8:13,1) =C(1,:);
    A_x_v(8:13,3) =C(5,:)./2;
    A_x_v(8:13,2) =C(6,:)./2;
    
A_x=[A_x_v(:,1:4).*1j*omega A_x_v(:,5:8) A_x_v(:,9:10).*1j*omega A_x_v(:,11:13)];
    

% terms on (-jk_y)
 A_y_v=zeros(13,13);
    A_y_v(1,10)   =K_eq_til;
    
    A_y_v(3,8)    =1;
    
    A_y_v(5,13)   =1;
    A_y_v(6,12)   =1;
    A_y_v(7,6)    =1;
    
    A_y_v(8:13,2) =C(2,:);
    A_y_v(8:13,3) =C(4,:)./2;
    A_y_v(8:13,1) =C(6,:)./2;

A_y=[A_y_v(:,1:4).*1j*omega A_y_v(:,5:8) A_y_v(:,9:10).*1j*omega A_y_v(:,11:13)];


% terms on (d/dz) 
 A_z_v=zeros(13,13);
    A_z_v(1,4)    =K_eq_til;
    
    A_z_v(4,8)    =1;
    
    A_z_v(5,7)    =1;
    A_z_v(6,6)    =1;
    A_z_v(7,5)    =1;
    
    A_z_v(8:13,3) =C(3,:);
    A_z_v(8:13,2) =C(4,:)./2;
    A_z_v(8:13,1) =C(5,:)./2;

A_z=[A_z_v(:,1:4).*1j*omega A_z_v(:,5:8) A_z_v(:,9:10).*1j*omega A_z_v(:,11:13)];


end


