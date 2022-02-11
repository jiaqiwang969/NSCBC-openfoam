
function [Diss_power,...
    K_x,K_y,K_z,Kinetic_energy,...
    P_Kx,P_Ky,P_Kz,Kinetic_power] = En_Solid(A,PHI,wave_num,thickness,rho,C,omega,k_x,k_y,q)

%% boolean matrices to select lines
L = eye(6);
L_usx = L(1,:);
L_usy = L(2,:);
L_usz = L(3,:);

dL = eye(6);
dL_usx = dL(1,:);
dL_usy = dL(2,:);
dL_usz = dL(3,:);

Lmn=eye(6);
Lxx = Lmn(1,:);
Lyy = Lmn(2,:);
Lzz = Lmn(3,:);
Lyz = Lmn(4,:);
Lxz = Lmn(5,:);
Lxy = Lmn(6,:);

%% e_tilde matrix

e_til_struct=[- 1j*k_x*L_usx;
    - 1j*k_y*L_usy;
    - dL_usz*A;
    0.5.*(- dL_usy*A - 1j*k_y*L_usz);
    0.5.*(- dL_usx*A - 1j*k_x*L_usz);
    0.5.*(- 1j*k_y*L_usx - 1j*k_x*L_usy)]*PHI;

%% Psi matrices

% STRUCTURAL DISSIPATION
Psi_struct= e_til_struct' * C'  *  e_til_struct ;


% KINETIC POWER
Xi_x = PHI' * (L_usx' * L_usx) * PHI;
Xi_y = PHI' * (L_usy' * L_usy) * PHI;
Xi_z = PHI' * (L_usz' * L_usz) * PHI;

%% Intermediate Matrix

% Primitive
prim_allstruct=zeros(6,6);
prim_Kxs=zeros(6,6);
prim_Kys=zeros(6,6);
prim_Kzs=zeros(6,6);

for ii=1:6;
    for jj=1:6;
        
        int=(exp(-1j*(wave_num(jj) - conj(wave_num(ii)))*thickness) - 1) /...
            (-1j*(wave_num(jj) - conj(wave_num(ii)) ));
        
        prim_allstruct(ii,jj) = Psi_struct(ii,jj) * int;
        
        
        % kinectic pow
        prim_Kxs(ii,jj) = Xi_x(ii,jj) * int;
        prim_Kys(ii,jj) = Xi_y(ii,jj) * int;
        prim_Kzs(ii,jj) = Xi_z(ii,jj) * int;
    end
end

%% Power of internal forces

Diss_power =  0.25*real(1i*omega* q' * prim_allstruct * q );

%% Kinetic Power

% structural nominal
K_x = 0.25*omega^2*rho * real(q' * prim_Kxs * q );
K_y = 0.25*omega^2*rho * real(q' * prim_Kys * q) ;
K_z = 0.25*omega^2*rho * real(q' * prim_Kzs * q) ;

Kinetic_energy=K_x+K_y+K_z;

% sum
P_Kx = omega * real(K_x);
P_Ky = omega * real(K_y);
P_Kz = omega * real(K_z);

Kinetic_power = P_Kx + P_Ky + P_Kz;

