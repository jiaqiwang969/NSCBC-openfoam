function [Omega_moins tau]=interface_PEM_fluid(Omega_plus)

m_moins=4;
m_plus=1;


D_1=zeros(2*m_moins,2*m_plus);
 D_1(4,1)=1;
 D_1(8,2)=1;


D_2=zeros(2*m_moins,m_moins-m_plus);
 D_2(1,1)=1;
 D_2(2,2)=1;
 D_2(3,3)=1;


Omega_moins=[D_1*Omega_plus D_2];

tau=[];