
function [P_Kx,P_Ky,P_Kz,P_Kstruct,...
    P_Kfx,P_Kfy,P_Kfz,P_Kfluid,...
    Kinetic_power_x,Kinetic_power_y,Kinetic_power_z,...
    Kinetic_power ]=...
    en_kin_PEM(A_layer,...
    PHI,...
    wave_num,...
    thickness,...
    omega,...
    k_x,...
    k_y,...
    rho_1,...
    rho_2,...
    rho_12_til,...
    rho_eq_til,...
    gamma_til,...
    phi,...
    alpha,...
    sig,...
    q)


% rho_eq_til=squeeze(rho_eq_til);
% gamma_til=squeeze(gamma_til);
% A_layer=squeeze(A_layer);

air_properties_maine;

%% boolean matrices to select lines
L = eye(8);
L_usx = L(1,:);
L_usy = L(2,:);
L_usz = L(3,:);
L_p = L(8,:);



%% VISCOUS DISSIPATION
utvec = (omega^2 .* rho_eq_til) \...
    ( [-1j*k_x.*L_p;-1j*k_y.*L_p;L_p*A_layer]- ...
    omega^2.*rho_eq_til*gamma_til*[L_usx;L_usy;L_usz]);

ufvec = ( utvec.*1/phi  - [L_usx;L_usy;L_usz].*(1-phi)/phi );

e_til_vis = ( ufvec - [L_usx;L_usy;L_usz] )*PHI;

if size(alpha)==1;
    alpha=alpha*eye(3);
end
if size(sig)==1;
    sig=sig*eye(3);
end

GAMMA_vis_x= e_til_vis(1,:)' * e_til_vis(1,:) ;
GAMMA_vis_y= e_til_vis(2,:)' * e_til_vis(2,:) ;
GAMMA_vis_z= e_til_vis(3,:)' * e_til_vis(3,:) ;


%% KINETIC POWER
Xi_x = PHI' * (L_usx' * L_usx) * PHI;
Xi_y = PHI' * (L_usy' * L_usy) * PHI;
Xi_z = PHI' * (L_usz' * L_usz) * PHI;

Xi_fx = PHI' * ufvec(1,:)' * ufvec(1,:) * PHI;
Xi_fy = PHI' * ufvec(2,:)' * ufvec(2,:) * PHI;
Xi_fz = PHI' * ufvec(3,:)' * ufvec(3,:) * PHI;


%% INTERMEDIATE MATRICES

% Primitive
prim_vis_x=zeros(8,8);
prim_vis_y=zeros(8,8);
prim_vis_z=zeros(8,8);
prim_Kx=zeros(8,8);
prim_Ky=zeros(8,8);
prim_Kz=zeros(8,8);
prim_Kfx=zeros(8,8);
prim_Kfy=zeros(8,8);
prim_Kfz=zeros(8,8);


for ii=1:8;
    for jj=1:8;
        int=(exp(-1j*(wave_num(jj) - conj(wave_num(ii)))*thickness) - 1) /...
            (-1j*(wave_num(jj) - conj(wave_num(ii)) ));
        
        
        % kinectic pow
        prim_Kx(ii,jj) = Xi_x(ii,jj) * int;
        prim_Ky(ii,jj) = Xi_y(ii,jj) * int;
        prim_Kz(ii,jj) = Xi_z(ii,jj) * int;
        prim_Kfx(ii,jj) = Xi_fx(ii,jj) * int;
        prim_Kfy(ii,jj) = Xi_fy(ii,jj) * int;
        prim_Kfz(ii,jj) = Xi_fz(ii,jj) * int;
        
        prim_vis_x (ii,jj) = GAMMA_vis_x (ii,jj) * int;
        prim_vis_y (ii,jj) = GAMMA_vis_y (ii,jj) * int;
        prim_vis_z (ii,jj) = GAMMA_vis_z (ii,jj) * int;
    end
end

%% Kinetic Energy and Power
w_vis_x= real( q' * prim_vis_x* q );
w_vis_y = real( q' * prim_vis_y* q );
w_vis_z = real( q' * prim_vis_z* q );

% structural nominal
K_x = 0.25*omega^2*rho_1 * real ( q' * prim_Kx * q );
K_y = 0.25*omega^2*rho_1 * real ( q' * prim_Ky * q );
K_z = 0.25*omega^2*rho_1 * real ( q' * prim_Kz * q );


% fluid coupling
Kfc =  0.25*omega^2*  real(rho_12_til)* [ w_vis_x ; w_vis_y ; w_vis_z ];

% fluid total
Kf_x= 0.25*omega^2* rho_2 *  real ( q' * prim_Kfx * q ) + Kfc(1);
Kf_y = 0.25*omega^2* rho_2 *  real ( q' * prim_Kfy * q ) + Kfc(2);
Kf_z = 0.25*omega^2* rho_2 *  real ( q' * prim_Kfz * q ) + Kfc(3);
K_fluid=Kf_x+Kf_y+Kf_z;

% sum
P_Kx = omega * K_x;
P_Ky = omega * K_y;
P_Kz = omega * K_z;
P_Kstruct=P_Kx+P_Ky+P_Kz;

P_Kfx = omega * (Kf_x + Kfc(1));
P_Kfy = omega * (Kf_y + Kfc(2));
P_Kfz = omega * (Kf_z + Kfc(3));
P_Kfluid=P_Kfx+P_Kfy+P_Kfz;

Kinetic_power_x = P_Kx + P_Kfx;
Kinetic_power_y = P_Ky + P_Kfy;
Kinetic_power_z = P_Kz + P_Kfz;
Kinetic_power  =  P_Kstruct  + P_Kfluid;

