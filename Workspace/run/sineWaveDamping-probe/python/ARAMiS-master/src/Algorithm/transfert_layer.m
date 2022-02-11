function    [Omega_plus,Xi]=transfert_layer(Omega_moins,A,d)



m_layer=size(A,1)/2;

% [Phi,V]=eigenshuffle_basic(-A);
% V_0=diag(V_0);
% [a,indice]=sort(diag(real(V_0)));


[Phi_0,V_0]=eig(-A);


[a,indice]=sort(diag(real(V_0)));


for i_m=1:2*m_layer
    Phi(:,i_m)=Phi_0(:,indice(2*m_layer+1-i_m));
    V(i_m,i_m)=V_0(indice(2*m_layer+1-i_m),indice(2*m_layer+1-i_m));
end

lambda=diag(V).';

% lambda=(V).';


Psi=inv(Phi);

Phi_k=Phi(:,1:m_layer-1);
Phi_r=Phi(:,m_layer:2*m_layer);
Psi_k=Psi(1:m_layer-1,:);
Psi_r=Psi(m_layer:2*m_layer,:);



%alpha_prime=Phi_r*diag([1 exp((lambda(5)-lambda(4))*d) exp((lambda(6)-lambda(4))*d) exp((lambda(7)-lambda(4))*d) exp((lambda(8)-lambda(4))*d)])*Psi_r;

alpha_prime=Phi_r*diag([1 exp((lambda(m_layer+1:2*m_layer)-lambda(m_layer))*d)])*Psi_r;


Xi_prime=[Psi_k;Psi_r(1,:)]*Omega_moins;


mat_exp=diag([exp((lambda(m_layer)-lambda(1:m_layer-1))*d) 1]);
Omega_plus=[Phi_k zeros(2*m_layer,1)]+alpha_prime*Omega_moins*(Xi_prime\mat_exp);

    mat_exp=zeros(m_layer);
for i=1:1:m_layer;
    
    mat_exp(i,i)=exp(-lambda(i)*d);
end
Xi=Xi_prime\mat_exp;



