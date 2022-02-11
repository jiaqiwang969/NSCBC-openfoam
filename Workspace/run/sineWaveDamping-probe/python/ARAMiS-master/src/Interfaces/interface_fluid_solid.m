function [Omega_moins tau]=interface_fluid_solid(Omega_plus)


m_moins=1;
m_plus=3;

D_plus=zeros(m_plus-m_moins,2*m_plus);

D_plus(1,4)=1;
D_plus(2,5)=1;

D_moins=zeros(2*m_moins,2*m_plus);
D_moins(1,3)=1;
D_moins(2,6)=-1;


tau=-inv(D_plus*Omega_plus(:,m_moins+1:m_plus))*D_plus*Omega_plus(:,1:m_moins);
Omega_moins=D_moins*(Omega_plus(:,1:m_moins)+Omega_plus(:,m_moins+1:m_plus)*tau);

  
