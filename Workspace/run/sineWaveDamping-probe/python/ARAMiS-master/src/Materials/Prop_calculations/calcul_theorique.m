%%  Calcul de la longueure d'onde pour les deux ondes de compressions et l'onde de cisaillement
%%  Méthode décrite dans Propagation of Sound in Porous Media de J.F. Allard (# d'équ. du livre)

delta=(((P_til.*rho_22_til)+(R_til.*rho_11_til)-(2.*Q_til.*rho_12_til)).^2) ...  %% équa. # 6.71
   -(4.*(P_til.*R_til-Q_til.^2).*(rho_11_til.*rho_22_til-rho_12_til.^2));

sdelta=(sqrt(delta));

 for ii=2:length(omega)
     if (abs(sdelta(ii)-sdelta(ii-1))>abs(sdelta(ii)+sdelta(ii-1)))
         sdelta(ii)=-sdelta(ii);        
     end  
 end

% Calcul des nombres d'ondes complexe
NOC2=sqrt((omega.^2./(2.*(P_til.*R_til-Q_til.^2)))...		%% équa. # 6.69
   .*(P_til.*rho_22_til+R_til.*rho_11_til-2.*Q_til.*rho_12_til-(sdelta)));

NOC1=sqrt((omega.^2./(2.*(P_til.*R_til-Q_til.^2)))...		%% équa. # 6.70
   .*(P_til.*rho_22_til+R_til.*rho_11_til-2.*Q_til.*rho_12_til+(sdelta)));


 
mu1=((P_til.*NOC1.^2)-(rho_11_til.*omega.^2))./((rho_12_til.*omega.^2)-(Q_til.*NOC1.^2)); %% équa. # 6.73
mu2=((P_til.*NOC2.^2)-(rho_11_til.*omega.^2))./((rho_12_til.*omega.^2)-(Q_til.*NOC2.^2)); %% équa. # 6.73


 
 

NOC3=omega.*sqrt(rho_s_til./MC);
mu3=-rho_12_til./rho_22_til;

