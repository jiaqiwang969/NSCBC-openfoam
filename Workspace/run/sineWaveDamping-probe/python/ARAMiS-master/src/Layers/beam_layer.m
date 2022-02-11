function [M_0,M_1,M_2,A_x,A_y,A_z,m_layer]=beam_layer(rho,C)



m_layer=3;
if length(rho)==1;
    rho_s=eye(3).*rho;
end


M_0=zeros(9,9);
    M_0(1,1)=-1;
    M_0(2,2)=-1;
    M_0(3,9)=-1;
    M_0(4,8)=-1;
    M_0(5,7)=-1;
    M_0(6,3)=-1;
    
% terms on (jw)
M_1=zeros(9,9);


% terms on (-w^2)
M_2=zeros(9,9);
    M_2(7:9,4:6)=rho_s;


% terms on (-jk_x)
A_x=zeros(9,9);
    A_x(1:6,4)=C(:,1);
    A_x(1:6,6)=1/2.*C(:,5);
    A_x(1:6,5)=1/2.*C(:,6);
    
    A_x(7,1)=1;
    A_x(8,3)=1;
    A_x(9,7)=1;


% terms on (-jk_y)
A_y=zeros(9,9);
    A_y(1:6,5)=C(:,2);
    A_y(1:6,6)=1/2.*C(:,4);
    A_y(1:6,4)=1/2.*C(:,6);
    
    A_y(7,3)=1;
    A_y(8,2)=1;
    A_y(9,8)=1;
    
% terms on (d/dz) 
A_z=zeros(9,9);
    A_z(1:6,6)=C(:,3);
    A_z(1:6,5)=1/2.*C(:,4);
    A_z(1:6,4)=1/2.*C(:,5);
    
    A_z(7,7)=1;
    A_z(8,8)=1;
    A_z(9,9)=1;
    
  

end


