disp('Computing the state matrices')

for i_f=1:length(in.f);
    
    % Plane wave def
    omega=2*pi*in.f(i_f);
    k_eq=omega/co;
    k_x=k_eq*in.k_ax;
    k_y=k_eq*in.k_ay;
    k_z=k_eq*in.k_az;
    
    for ii=1:length(L)
        
        
        switch L(ii).material.type
            case 'fluid'
                [M_0,M_1,M_2,A_x,A_y,A_z,m_layer]=fluid_layer(L(ii).material.rho,L(ii).material.K);
            case 'solid'
                [M_0,M_1,M_2,A_x,A_y,A_z,m_layer]=solid_layer(L(ii).material.rho,L(ii).material.C);
            case 'pem'
                [M_0,M_1,M_2,A_x,A_y,A_z,m_layer]=pem_layer(L(ii).material.rho_eq_til(:,:,i_f),L(ii).material.gamma_til(:,:,i_f),L(ii).material.rho_s_til(:,:,i_f),L(ii).material.K_eq_til(i_f),L(ii).material.C);        
        end
        
        L(ii).Alpha(:,:,i_f)=alpha_matrix(M_0,M_1,M_2,A_x,A_y,A_z,omega,k_x,k_y,m_layer);
        
    end
end
