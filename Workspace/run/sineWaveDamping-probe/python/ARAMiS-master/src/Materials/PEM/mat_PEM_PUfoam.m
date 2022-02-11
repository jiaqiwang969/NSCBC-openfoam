phi=0.997;

sig=4500*eye(3);
tort=1.17000*eye(3);
LCV=96.1e-6;
LCT=2*96.1e-6;

rho_1=35.000;
E=164e3;
poisson=0.0;
eta=0;
   

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

    C_i=C;
sig_i=sig;
