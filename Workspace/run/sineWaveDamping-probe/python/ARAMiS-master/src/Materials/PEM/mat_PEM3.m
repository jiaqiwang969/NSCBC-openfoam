phi=0.97;
sig=36000*eye(3);
tort=1.2000*eye(3);
LCV=0.56000E-04;
LCT=0.11200E-03;
rho_1=120.000;
E=8.0000000E+10;
poisson=0.00000E+00;
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
