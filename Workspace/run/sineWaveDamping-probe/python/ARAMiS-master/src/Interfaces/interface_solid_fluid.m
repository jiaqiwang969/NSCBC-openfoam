function [Omega_moins tau]=interface_solid_fluid(Omega_plus)

m_moins=3;
m_plus=1;


D_1=zeros(2*m_moins,2*m_plus);
D_1(3,1)=1;
D_1(6,2)=-1;


D_2=zeros(2*m_moins,m_moins-m_plus);
D_2(1,1)=1;
D_2(2,2)=1;


Omega_moins=[D_1*Omega_plus D_2];

tau=[];

