    %% Material : Rubber

    rho=2000;
    
%     G0=3.87e6;
%     alfarub=0.2374;
%     w0=1.39e3;
%     poisson=0.45;   
% 
%     %G = G0*(1+(-1i*omega/w0)^alfarub);
%     G=G0;
%     young=2*G*(1+poisson);


    E=11223000;
    poisson=0.45;    
    eta=0.03;
    
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
    
