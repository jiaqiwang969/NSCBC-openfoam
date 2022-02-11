disp('Computing the solution in terms of acoustic indicators and state vector')

n=length(L);

for ii=1:n;
    switch L(ii).material.type
        case 'fluid'
            L(ii).material.typepros=1;
        case 'solid'
            L(ii).material.typepros=2;
        case 'pem'
            L(ii).material.typepros=3;
    end
end

for i_f=1:length(in.f);
    
    % Plane wave def
    omega=2*pi*in.f(i_f);
    k_eq=omega/co;
    k_x=k_eq*in.k_ax;
    k_y=k_eq*in.k_ay;
    k_z=k_eq*in.k_az;
    
    switch in.termination
        case 'transmission'
            LT = [-1j*k_z/(rho_a*omega^2);1];
        case 'rigid backing'
            LT = [0;1];
    end
    
    % Last layer
    switch L(n).material.type
        case 'solid'
            [L(n).OP L(n).TAU] = interface_solid_fluid(LT);
        case 'pem'
            [L(n).OP L(n).TAU] = interface_PEM_fluid(LT);
    end
    
    for jj=n:-1:1;
        [L(jj).OM,L(jj).X]=transfert_layer(L(jj).OP,L(jj).Alpha(:,:,i_f),L(jj).d);
        
        if jj==1
            break
        else [L(jj).OM,L(jj).X]=transfert_layer(L(jj).OP,L(jj).Alpha(:,:,i_f),L(jj).d);
            
            if and(L(jj-1).material.typepros==2 , L(jj).material.typepros==1)
                [L(jj-1).OP L(jj-1).TAU]= interface_solid_fluid(L(jj).OM);
            elseif and(L(jj-1).material.typepros==2 , L(jj).material.typepros==3)
                [L(jj-1).OP L(jj-1).TAU]= interface_solid_PEM(L(jj).OM);
            elseif and(L(jj-1).material.typepros==3 , L(jj).material.typepros==2)
                [L(jj-1).OP L(jj-1).TAU]= interface_PEM_solid(L(jj).OM);
            elseif and(L(jj-1).material.typepros==3 , L(jj).material.typepros==1)
                [L(jj-1).OP L(jj-1).TAU]= interface_PEM_fluid(L(jj).OM);
            elseif and(L(jj-1).material.typepros==1 , L(jj).material.typepros==2)
                [L(jj-1).OP L(jj-1).TAU]= interface_fluid_solid(L(jj).OM);
            elseif and(L(jj-1).material.typepros==1 , L(jj).material.typepros==3)
                [L(jj-1).OP L(jj-1).TAU]= interface_fluid_PEM(L(jj).OM);
            else L(jj-1).OP = L(jj).OM;
            end
            
        end
    end
    switch L(1).material.type
        case 'solid'
            [LIOP LITAU]= interface_fluid_solid(L(1).OM);
        case 'pem'
            [LIOP LITAU]= interface_fluid_PEM(L(1).OM);
    end
    
    % Semi-infinite incidence fluid space (SIF)
    LOfl=[1j*k_z/(rho_a*omega^2);1];
    LSfl=[-1j*k_z/(rho_a*omega^2);1];
    
    
    % Computation Translation Matrix Solution
    sortie_solver=resolution_recursive(LIOP,LOfl,LSfl) ;
    
    switch in.termination
        case 'rigid backing'
            out.R(i_f)=sortie_solver(2);
            out.Absorpt(i_f) = 1- abs(out.R(i_f))^2;
            
            XI=sortie_solver(1);
            
            %interface with first layer
            L(1).XM= [XI ; LITAU*XI];
            
            for jj=2:n
                % propagations
                L(jj-1).XP = L(jj-1).X * L(jj-1).XM;
                
                % interfaces
                if and(L(jj-1).material.typepros==2 , L(jj).material.typepros==1)
                    L(jj).XM = L(jj-1).XP(1);
                elseif L(jj-1).material.typepros < L(jj).material.typepros
                    L(jj).XM = [L(jj-1).XP; L(jj-1).TAU*L(jj-1).XP];
                elseif and(L(jj-1).material.typepros==3 , L(jj).material.typepros==2)
                    L(jj).XM = L(jj-1).XP(1:3);
                elseif and(L(jj-1).material.typepros==3 , L(jj).material.typepros==1)
                    L(jj).XM = L(jj-1).XP(1);
                else L(jj).XM = L(jj-1).XP;
                end
            end
            
            % Last layer propagation and interface
            L(n).XP = L(n).X * L(n).XM;
            XRAD = L(n).XP(1);
            
            
        case 'transmission'
            XI=sortie_solver(1);
            
            %interface with first layer
            L(1).XM= [XI ; LITAU*XI];
            
            for jj=2:n
                % propagations
                L(jj-1).XP = L(jj-1).X * L(jj-1).XM;
                
                % interfaces
                if and(L(jj-1).material.typepros==2 , L(jj).material.typepros==1)
                    L(jj).XM = L(jj-1).XP(1);
                elseif L(jj-1).material.typepros < L(jj).material.typepros
                    L(jj).XM = [L(jj-1).XP; L(jj-1).TAU*L(jj-1).XP];
                elseif and(L(jj-1).material.typepros==3 , L(jj).material.typepros==2)
                    L(jj).XM = L(jj-1).XP(1:3);
                elseif and(L(jj-1).material.typepros==3 , L(jj).material.typepros==1)
                    L(jj).XM = L(jj-1).XP(1);
                else L(jj).XM = L(jj-1).XP;
                end
            end
            
            % Last layer propagation and interface
            L(n).XP = L(n).X * L(n).XM;
            XRAD = L(n).XP(1);
            
            %% Transmission loss
            out.TL(i_f) = -20*log10(abs(XRAD));
            
    end
    %% Calculation of the state vector
    for jj=1:n
        L(jj).statevector.M(:,i_f)=L(jj).OM * L(jj).XM;
        L(jj).statevector.P(:,i_f)=L(jj).OP * L(jj).XP;
    end
    RAD.statevector(:,i_f)= LIOP * XRAD ;
    
    
    %
    %   for ii=1:4;
    %     L(ii).statevector(:,i_f)=L(ii).OP(:,:,i_f) * L(ii).XP(:,:,i_f);
    %   end
    %
    %   L(1).statevector_0(:,i_f)=L(1).OM(:,:,i_f) * L(1).XM(:,:,i_f);
    %   L(5).statevector(:,i_f)=L(5).OP(:,:,i_f) * L(5).XP(:,:,i_f);
    %
    %   out.press(i_f) = (abs(L(5).statevector(2,i_f)).^2)./(abs(L(1).statevector_0(2,i_f)).^2);
    %
    %   out.SPL(i_f) = 10*log10(out.press(i_f));
    %
end



