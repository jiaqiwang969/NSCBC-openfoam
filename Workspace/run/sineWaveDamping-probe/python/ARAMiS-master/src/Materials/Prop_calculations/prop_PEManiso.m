function [K_eq_til,rho_eq_til,gamma_til,rho_s_til,rho_11_til,rho_12_til,rho_22_til]=prop_PEManiso(omega,rho_a,vis,Po,NPR,gamma,phi,sig,alpha,LCV,LCT,rho_1)

rho_0=rho_a;
P_0=Po;
if size(sig)==1;
    sig=sig*eye(3);
end
if size(alpha)==1;
    alpha=alpha*eye(3);
end


%% Dynamic tortuosity
% Allard Atalla p.84 eq (5.36)
%
nu=vis/rho_0;
%nup=vis/(rho_0*NPR);
q_0= inv(sig).*vis;
%q_0p=phi.*((LCT^2)/8);

alpha_til = alpha + inv(1j*omega*q_0)*nu*phi* sqrt(eye(3) + (1i*omega/nu)*(2*alpha*q_0/(phi*LCV))^2);
%alpha_til= (8*nup/(1i*omega*LCT^2))*sqrt(1 + (1i*omega/nup)*(LCT/4)^2) + 1;

%%  Apparent densities
% Khurana Boeckx Lauriks Leclaire Dazel Allard
% JASA (2009) 125 (2) 915-921

rho_12_til = phi*rho_0*(eye(3)-alpha_til);
rho_11_til = rho_1*eye(3)-rho_12_til;
rho_22_til = phi*rho_0*eye(3) - rho_12_til;


%% Bulk modulus of the fluid - K_eq
% Allard Atalla p.90 eq(5.51)

q_0p=phi.*((LCT^2)/8);
nup=inv(rho_0*NPR)*vis;
%Gwp = sqrt(1 + (1i*omega/nup)*(2*q_0p/(phi*LCT))^2) ;
Gwp = sqrt(1 + (1i*omega/nup)*(LCT/4)^2);

K_eq_til=inv(phi)*inv(gamma - (gamma-1)*inv( 1 + nup*phi*inv(1j*omega*q_0p)*Gwp))*gamma*P_0;


%% Bulk modulus of the fluid - K_eq

gamma_til = phi*( inv(rho_22_til)*rho_12_til - eye(3)*(1-phi)/phi );

rho_eq_til = rho_22_til/(phi^2);


rho_til = rho_11_til - inv(rho_22_til)*(rho_12_til^2);
rho_s_til = rho_til + gamma_til^2 * rho_eq_til;