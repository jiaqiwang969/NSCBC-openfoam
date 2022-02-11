function [Omega_moins tau]=interface_solid_solid(Omega_plus)


m_moins=3;
m_plus=3;

Omega_moins=Omega_plus;
tau=eye(2*m_moins);


%tau=-inv(D_plus*Omega_plus(:,m_moins+1:m_plus))*D_plus*Omega_plus(:,1:m_moins);
%Omega_moins=D_moins*(Omega_plus(:,1:m_moins)+Omega_plus(:,m_moins+1:m_plus)*tau);

    