function [Omega_moins tau]=interface_fluid_fluid(Omega_plus)


m_moins=1;
m_plus=1;

Omega_moins=Omega_plus;
tau=eye(2*m_moins);

end

