function [M_0,M_1,M_2,A_x,A_y,A_z,m_layer]=pem_layer(rho_eq_til,gamma_til,rho_s_til,K_eq_til,H)

%% state vector
% transpose of [ utx uty Sxx Syy Sxy usx usy usz utz Szz Syz Sxz p]

 %% Porous layer
    
    m_layer=4;
    
    
    M_0=zeros(13,13);
    M_0(7,13) = 1;
    M_0(8,3) = -1;
    M_0(9,4) = -1;
    M_0(10,12) = -1;
    M_0(11,11) = -1;
    M_0(12,10) = -1;
    M_0(13,5) = -1;
    
    
    % terms on (jw)
    M_1=zeros(13,13);
    
    
    % terms on (-w^2)
    rhogam=rho_eq_til*gamma_til;
    if size(rhogam)==1;
        rhogam=rhogam*eye(3);
        rho_eq_til=rho_eq_til*eye(3);
        rho_s_til=rho_s_til*eye(3);
    end
    
    M_2=zeros(13,13);
    M_2(1:3,6:8) = rho_s_til;
    M_2(1:3,1:2) = rhogam(1:3,1:2);
    
    % added
    %M_2(3,9) = rhogam(3,3);
    M_2(1:3,9) = rhogam(1:3,3);
    %
    
    M_2(4:6,6:8) = rhogam;
    
    %added
    % M_2(4:5,1:2) = rho_eq_til(1:2,1:2);
    % M_2(6,9) = rho_eq_til(3,3);
    M_2(4:6,1:2) = rho_eq_til(1:3,1:2); 
    M_2(4:6,9) = rho_eq_til(1:3,3);
    
    % terms on (-jk_x)
    A_x=zeros(13,13);
    A_x(1,3) = 1;
    A_x(2,5) = 1;
    A_x(3,10) = 1;
    A_x(4,13) = -1;
    A_x(7,1) = K_eq_til;
    
    A_x(8:13,6) = H(:,1);
    A_x(8:13,7) = H(:,6);
    A_x(8:13,8) = H(:,5);
    
    % terms on (-jk_y)
    A_y=zeros(13,13);
    A_y(1,5) = 1;
    A_y(2,4) = 1;
    A_y(3,11) = 1;
    A_y(5,13) = -1;
    A_y(7,2) = K_eq_til;
    
    A_y(8:13,6)=H(:,6);
    A_y(8:13,7)=H(:,2);
    A_y(8:13,8)=H(:,4);
    
    % terms on (d/dz)
    A_z=zeros(13,13);
    A_z(1:3,10:12) = eye(3);
    A_z(6,13) = -1;
    A_z(7,9) = K_eq_til;
        
    A_z(8:13,6)=H(:,5);
    A_z(8:13,7)=H(:,4);
    A_z(8:13,8)=H(:,3);

end


