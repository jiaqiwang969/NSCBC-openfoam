% Solid Parameters

rho=1700;

E=1.5e10;
poisson=0.3;
eta=0.01;

% Perforation parameters
% hole diameter
ls=2e-3;
% hole spacing
ds=3.5e-3;

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


