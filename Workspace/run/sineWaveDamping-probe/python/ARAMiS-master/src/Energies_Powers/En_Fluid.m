function [Diss_power,...
    K_x,K_y,K_z,Kinetic_energy,...
    P_Kx,P_Ky,P_Kz,Kinetic_power] = En_Fluid(A_layer,PHI,wave_num,thickness,rho,K,omega,k_x,k_y,q)


% boolean matrices to select lines
L = eye(2);
L_uz = L(1,:);
L_p = L(2,:);

dL = eye(2);
dL_uz = dL(1,:);
dL_p = dL(2,:);

ufx=1j*k_x/(-omega^2*rho) * L_p;
ufy=1j*k_y/(-omega^2*rho) * L_p;

%% e_tilde matrix

e_tilx=ufx*PHI;
e_tily=ufy*PHI;
e_tilz=-dL_uz*A_layer*PHI;

% dissipated
Psi_x = e_tilx' * K' * 1i * omega * e_tilx;
Psi_y = e_tily' * K' * 1i * omega * e_tily;
Psi_z = e_tilz' * K' * 1i * omega * e_tilz;

% kinetic
Xx = PHI' * (ufx' * ufx) * PHI;
Xy = PHI' * (ufy' * ufy) * PHI;
Xz = PHI' * (L_uz' * L_uz) * PHI;

%% Intermediate matrix

% Primitive

prim_dissx=zeros(2,2);
prim_dissy=zeros(2,2);
prim_dissz=zeros(2,2);
prim_Kx=zeros(2,2);
prim_Ky=zeros(2,2);
prim_Kz=zeros(2,2);

for ii=1:2;
    for jj=1:2;
        int=(exp(-1j*(wave_num(jj) - conj(wave_num(ii)))*thickness) - 1) /...
            (-1j*(wave_num(jj) - conj(wave_num(ii)) ));
        
        prim_dissx(ii,jj) = Psi_x(ii,jj) * int;
        prim_dissy(ii,jj) = Psi_y(ii,jj) * int;
        prim_dissz(ii,jj) = Psi_z(ii,jj) * int;
        prim_Kx(ii,jj) = Xx(ii,jj) * int;
        prim_Ky(ii,jj) = Xy(ii,jj) * int;
        prim_Kz(ii,jj) = Xz(ii,jj) * int;
    end
end

% Power of internal forces

W_x = 0.25*real( q' * prim_dissx* q );
W_y = 0.25*real( q' * prim_dissy* q );
W_z = 0.25*real( q' * prim_dissz* q );

Diss_power=W_x + W_y + W_z;

% Kinetic Power
%  nominal
K_x = 0.25*omega^2*rho * real(q' * prim_Kx * q );
K_y = 0.25*omega^2*rho * real(q' * prim_Ky * q) ;
K_z = 0.25*omega^2*rho * real(q' * prim_Kz * q) ;
Kinetic_energy = K_x + K_y + K_z ;

% sum
P_Kx = omega * real(K_x);
P_Ky = omega * real(K_y);
P_Kz = omega * real(K_z);

Kinetic_power = P_Kx + P_Ky + P_Kz;
end
