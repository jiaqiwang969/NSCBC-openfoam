function    [Omega_plus,Xi]=transfert_fluid(Omega_moins,omega,k_x,K_0,rho_0,d)


    A=zeros(2,2);

    A(1,2)=k_x^2/(rho_0*omega^2)-1/K_0;
    A(2,1)=rho_0*omega^2;

    % Methode de Resolution ? la wang
    OPTS.tol=1e-19;
    [Phi_00,V_00]=eigs(-A,2,0,OPTS);
    
    
    delta=omega*sqrt(rho_0/K_0);
    beta=sqrt(delta^2-k_x^2);




alpha=-j*K_0*delta^2;

 V_0=diag([j*beta,-j*beta]);
%     diag(V_0)
%     diag(V_00)
%     pause



Phi_0(1,1)= beta;
Phi_0(1,2)=-beta;


Phi_0(2,1)=-alpha;
Phi_0(2,2)=-alpha;


%     for iiii=1:2
%     [(-A)*Phi_0(:,iiii) V_0(iiii,iiii)*Phi_0(:,iiii) (-A)*Phi_0(:,iiii)-V_0(iiii,iiii)*Phi_0(:,iiii)]
% end
% pause
    
    
    
    
    [a,indice]=sort(diag(imag(V_0)));
    
    
    for i_m=1:2
       Phi(:,i_m)=Phi_0(:,indice(2+1-i_m));
       V(i_m,i_m)=V_0(indice(2+1-i_m),indice(2+1-i_m));
    end
    
    lambda=diag(V);
    
    Phi_inv=inv(Phi);
    
    Phi_1=Phi(:,1);
    Phi_2=Phi(:,2);
    
    Psi_1=Phi_inv(1,:);
    Psi_2=Phi_inv(2,:);
    
    
    
    Omega_plus=Phi_1+exp((lambda(2)-lambda(1))*d)*((Phi_2*Psi_2*Omega_moins)/(Psi_1*Omega_moins));
    
   %Omega_plus=MM*Omega_moins;
    
    Xi=exp(-lambda(1)*d)/(Psi_1*Omega_moins);
    
    
    
