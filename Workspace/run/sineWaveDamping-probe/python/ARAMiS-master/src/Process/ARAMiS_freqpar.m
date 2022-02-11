disp('Computing the frequency dependent parameters')

for ii=1:length(L)
    
    switch L(ii).material.type
        
        case 'fluid'
	    eval(L(ii).material.sheet);
            L(ii).material.K=K;
            L(ii).material.rho=rho;  
            
        case 'solid'
            eval(L(ii).material.sheet);
            L(ii).material.C=C;
            L(ii).material.rho=rho;
            
        case 'pem';
            
            for i_f=1:length(in.f);
                
                % Plane wave def
                omega=2*pi*in.f(i_f);
                k_eq=omega/co;
                k_x=k_eq*in.k_ax;
                k_y=k_eq*in.k_ay;
                k_z=k_eq*in.k_az;
                
                eval(L(ii).material.sheet);
                
                if L(ii).material.rotation == 1
                    L(ii).material.C = C_i;
                    L(ii).material.sig=sig_i;
                elseif L(ii).material.rotation == 2
                    sig=prop_rot(L(ii).material.alfa_rot,L(ii).material.beta_rot,L(ii).material.gamma_rot,sig_i);
                    L(ii).material.sig=sig;
                    L(ii).material.C=hookes_rot(L(ii).material.alfa_rot,L(ii).material.beta_rot,L(ii).material.gamma_rot,C_i);
		elseif L(ii).material.rotation == 3
		  [L(ii).material.C,L(ii).material.E,L(ii).material.nu]=closest_iso(C_i);
		  L(ii).material.sig=mean(diag(sig_i));
		end
                
                sig=L(ii).material.sig;
                prop_aniso_jppm_backup;
                
                L(ii).material.rho_1= rho_1;
                L(ii).material.rho_0 = rho_0;
                L(ii).material.rho_2 = phi*rho_0;
                L(ii).material.rho_12_til(:,:,i_f) = rho_12_til;
                L(ii).material.rho_eq_til(:,:,i_f) = rho_eq_til;
                L(ii).material.rho_s_til(:,:,i_f) = rho_s_til;
                L(ii).material.LCV = LCV;
                L(ii).material.LCT = LCT;
                L(ii).material.K_eq_til(i_f) = K_eq_til;
                L(ii).material.gamma_til(:,:,i_f) = gamma_til;
                L(ii).material.phi = phi;
                L(ii).material.tort = tort;
                
            end
    end
end
