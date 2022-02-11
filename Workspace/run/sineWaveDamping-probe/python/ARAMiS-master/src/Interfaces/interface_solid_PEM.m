function [Omega_moins tau]=interface_solid_PEM(Omega_plus)


m_moins=3;
m_plus=4;

D_plus=zeros(m_plus-m_moins,2*m_plus);

D_plus(1,3)=1;
D_plus(1,4)=-1;

D_moins=zeros(2*m_moins,2*m_plus);
D_moins(1,1)=1;
D_moins(2,2)=1;
D_moins(3,4)=1;
D_moins(4,5)=1;
D_moins(5,6)=1;
D_moins(6,7)=1;
D_moins(6,8)=-1;


tau=-inv(D_plus*Omega_plus(:,m_moins+1:m_plus))*D_plus*Omega_plus(:,1:m_moins);
Omega_moins=D_moins*(Omega_plus(:,1:m_moins)+Omega_plus(:,m_moins+1:m_plus)*tau);

    