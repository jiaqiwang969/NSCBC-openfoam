%% Function for the calculations of the Hooke's tensor damping depending on the model

%         Elastic model
% eta   = elastic damping factor [1]

%         Anelastic model ,based on Cuenca et al. (2012), Cuenca et al. (2014)
% alpha = Fractional derivative order [1]
% beta  = Relaxation frequency [rad.s^{-1}]
% b     = Anelastic contribution [1]
% omega = 2*pi*f

%         Hooke's tensor
% C_in  = Undamped Hooke's tensor [N.m^{-2}]


function [C_out]=el_mod(eta,alpha,beta,b,omega,C_in,model)

switch model
    case 'elastic'
        C_out=C_in.*(1+1j*eta);
    case 'anelastic'
        C_out=C_in*(1 + b*(1i*omega/beta)^alpha /(1 + (1i*omega/beta)^alpha));
end

end

%  Juan Pablo Parra Martinez
%  jppm@kth.se
%  July,2014