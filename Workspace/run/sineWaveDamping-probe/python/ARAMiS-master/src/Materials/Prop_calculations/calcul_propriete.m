



%[MID,NAME,TYP,phi,sig,alpha,LCV,LCT,rho_1,young,poisson,eta]=data_materiau(matid);



%%  Calcul des masses volumiques apparentes

rho_0=rho_a;
rho_12=-phi*rho_0*(alpha-1);
rho_11=rho_1-rho_12;
rho_2=phi*rho_0;
rho_22=rho_2-rho_12;




%%  Fréquence caractéristiques

mu_0=vis;
M=8*mu_0*alpha/(phi*sig*LCV^2);
omega_p=omega*rho_0*alpha/(sig*phi);
asw=M*i*omega_p/2;
asw=sqrt(1+asw);
asw=alpha-alpha*i*asw./omega_p;



P_0=Po;
omega_t=(NPR*omega*rho_0*LCT^2)/(8*mu_0);
K_f_til=i*0.5*omega_t;
K_f_til=sqrt(1+K_f_til);
K_f_til=1-i*K_f_til./omega_t;
K_f_til=gamma*P_0./(gamma-(gamma-1)./K_f_til);


MC=(young*(1+i*eta))/(2*(1+poisson));
N=MC;
KB=(2/3)*MC*(1+poisson)/(1-2*poisson);
P_til=(((1-phi)^2)/phi).*K_f_til+KB+(4/3)*MC;
P_hat=P_til-K_f_til*(1-phi)^2./phi;
A_til=P_til-2*N;
A_hat=P_hat-2*N;





%%  Calcul du module de compressibilité de l'air

c_0=co;
K_0=rho_0*c_0^2;

%%  Calcul des masses volumiques dynamiques complexes de Biot

B2=phi*rho_0*(alpha-asw);


rho_11_til=rho_11-B2;  %%  La masse volumique apparente dynamique complexe de la phase solide
rho_12_til=rho_12+B2;  %%  Couplage inertiel dynamique entre les deux phases
rho_22_til=rho_22-B2;  %%  La masse volumique apparente dynamique complexe de la phase fluide
rho_eq_til=rho_22_til/(phi^2);
%%  Calcul de la masse volumique effective dynamique de la matrice solide

rho_til=rho_11_til-((rho_12_til.^2)./rho_22_til);

%%  Calcul de la masse volumique effective dynamique de la phase fluide (model Johnson-Allard)

rho_f_til=rho_22_til/phi;

%%  Calcul du coefficient de couplage volumique

gamma_til=phi*(rho_12_til./rho_22_til-(1-phi)/phi);

%%  Calcul de la masse volumique effective dynamique de la phase fluide pour une matrice souple

rho_f_til_prim=1./((1./rho_f_til)+((gamma_til.^2)./(phi*rho_til)));

%%  Calcul de la tortuosité dynamique

alpha_til=rho_f_til./rho_0;


rho_s_til=rho_til+gamma_til.^2.*rho_eq_til;


%%  Calcul du coefficient de couplage élastique Q_til

Q_til=(1-phi)*K_f_til;

%%  Calcul du module de compression de l'air (occupant une fraction phi) R_til

R_til=phi*K_f_til;
K_eq_til=R_til/phi^2;

