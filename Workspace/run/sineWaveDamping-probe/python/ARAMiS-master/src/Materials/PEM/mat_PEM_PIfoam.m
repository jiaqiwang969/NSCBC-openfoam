phi=0.976;

sig=1000e3*eye(3);
tort=1.17000*eye(3);
LCV=39e-6;
LCT=2*39e-6;

rho_1=8.000;
E=848e3;
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
