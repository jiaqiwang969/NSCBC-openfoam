% From  Rehman, Potel, Belleval, Ultrasonics (1998)
% 
rho=1577;

C_0=1e9.*[ 13.7+0.13j   7.10+0.04j  6.7+0.04j  0   0   0;
    7.10+0.04j   13.7+0.13j  6.7+0.04j  0   0   0;
    6.7+0.04j    6.7+0.04j  126+0.73j    0    0     0;
    0          0         0      5.8+0.73j    0     0;
    0          0         0          0  5.8+0.73j    0;
    0          0         0          0    0       3.3+0.05j];

    
% Epopxy matrix From ?str?m (1997)
% 
E=2.6e9;
poisson=0.3;
eta=0.01;

young=E*(1+1j*eta);

lambda=(young*poisson)/((1+poisson)*(1-2*poisson));
mu=(young)/(2*(1+poisson));


C_SGM=zeros(6,6);
C_SGM(1,:)=[2*mu+lambda lambda lambda 0 0 0];
C_SGM(2,:)=[lambda 2*mu+lambda lambda 0 0 0];
C_SGM(3,:)=[lambda lambda 2*mu+lambda 0 0 0];
C_SGM(4,4)=2*mu;
C_SGM(5,5)=2*mu;
C_SGM(6,6)=2*mu;
   
rho_SGM=1200;

C_MU=eye(6,6);  
rho_MU=10;