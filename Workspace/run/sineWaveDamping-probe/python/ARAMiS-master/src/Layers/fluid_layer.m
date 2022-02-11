function [M_0,M_1,M_2,A_x,A_y,A_z,m_layer]=fluid_layer(rho,K)


%% equations discretization

%         u_x
%    u =  u_y
%         u_z
%          p


rho_f=eye(3)*rho;

M_0=[0 0 0 0;
     0 0 0 0;
     0 0 0 0;
     0 0 0 1];

M_1=zeros(4,4);

M_2=zeros(4,4);
    M_2(1:3,1:3)=-rho_f;

A_x=[0 0 0 1;
     0 0 0 0;
     0 0 0 0;
     K 0 0 0];

A_y=[0 0 0 0;
     0 0 0 1;
     0 0 0 0;
     0 K 0 0];

A_z=[0 0 0 0;
     0 0 0 0;
     0 0 0 1;
     0 0 K 0];

m_layer=1;

end
