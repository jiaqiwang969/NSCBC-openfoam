function [K_db]=delany_bazley(rho,c,sigma,f)

    omega=2*pi*f;

    X_db    = rho*f/sigma;
    k_db    = (omega/c)*(1+0.0978*(X_db^(-0.7))-1j*0.189*(X_db^(-0.595)));
    K_db    =(omega^2)*rho/(k_db^2);
    Z_db    = c*rho*(1+0.0571*(X_db^(-0.754))-1j*0.087*(X_db^(-0.732)));
    
end
