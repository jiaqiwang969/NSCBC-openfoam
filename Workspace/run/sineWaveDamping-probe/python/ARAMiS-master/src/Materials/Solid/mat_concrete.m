    %% Material : Concrete (TEORED)
    % Isotropic material, anisotropic model

    rho=2300;
    
    E=2.6e10;
    poisson=0.1;    
    eta=0.02;
    
    young=E*(1+1j*eta);
    
    lambda=(young*poisson)/((1+poisson)*(1-2*poisson));
    mu=(young)/(2*(1+poisson));
    
    
   C=zeros(6,6);
    C(1,:)=[2*mu+lambda lambda lambda 0 0 0];
    C(2,:)=[lambda 2*mu+lambda lambda 0 0 0];
    C(3,:)=[lambda lambda 2*mu+lambda 0 0 0];
    C(4,4)=2*mu;
    C(5,5)=2*mu;
    C(6,6)=2*mu;
    
    
