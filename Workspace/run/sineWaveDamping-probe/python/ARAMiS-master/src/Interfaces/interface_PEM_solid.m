function [Omega_moins tau]=interface_PEM_solid(Omega_plus)

m_moins=4;
m_plus=3;


D_1=zeros(2*m_moins,2*m_plus);
 D_1(1,1)=1;
 D_1(2,2)=1;
 D_1(3,3)=1;
 D_1(4,3)=1;
 D_1(5,4)=1;
 D_1(6,5)=1;
 D_1(7,6)=1;


D_2=zeros(2*m_moins,m_moins-m_plus);
D_2(7,1)=1; 
D_2(8,1)=1;
 
Omega_moins=[D_1*Omega_plus D_2];

tau=[];

