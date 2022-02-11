function [Alpha]=alpha_matrix(M_0,M_1,M_2,A_x,A_y,A_z,omega,k_x,k_y,m_layer)

R = M_0 + M_1.*1j*omega + M_2.*omega^2 - 1j*k_x.*A_x - 1j*k_y.*A_y;

%% Numerical calculation of Eigenvalues and Eigenvectors

% eigenvectors to the right

[PHI,LAMBDA]=eig(A_z,R);

[toto,indice]=sort(diag(abs(LAMBDA)),'descend');

for i=1:length(indice)
    PHI_n(:,i)=PHI(:,indice(i));
    LAMBDA_n(i,i)=LAMBDA(indice(i),indice(i));
end

LAMBDA_e=LAMBDA_n(1:2*m_layer,1:2*m_layer);
PHI_e=PHI_n(:,1:2*m_layer);
% PHI_0=PHI_n(:,2*m_layer+1:end)
% PHI;


% eigenvectors to the left
[PSI,LAMBDA_prime]=eig(A_z',R');



[toto,indice]=sort(diag(abs(LAMBDA_prime)),'descend');

for i=1:length(indice)
    PSI_n(:,i)=PSI(:,indice(i));
end


PSI_e=PSI_n(:,1:2*m_layer);
PSI_0=PSI_n(:,2*m_layer+1:end);


R_Sprime=PSI_0'*R;
R_S=PSI_e'*R;

B=R_Sprime*(eye(length(R_Sprime(1,:))) - PHI_e*LAMBDA_e*(inv(R_S*PHI_e*LAMBDA_e)*R_S) );

B_Sprime=   B(:,1:end-2*m_layer);
B_S=        B(:,end+1-2*m_layer:end);

T=[-inv(B_Sprime)*B_S;eye(2*m_layer)];

Alpha = - inv(PSI_e'*A_z*T)*(PSI_e'*R*T);


end
