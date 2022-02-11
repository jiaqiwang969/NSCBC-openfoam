
function [W_struct,...
    W_th,...
    W_vis_x,W_vis_y,W_vis_z,W_vis,...
    Diss_power,...
    K_x,K_y,K_z,K_struct,...
    Kf_x,Kf_y,Kf_z,K_fluid,...
    Kinetic_energy,...
    P_Kx,P_Ky,P_Kz,P_Kstruct,...
    P_Kfx,P_Kfy,P_Kfz,P_Kfluid,...
    Kinetic_power_x,Kinetic_power_y,Kinetic_power_z,...
    Kinetic_power,...
    ufvec] =...
    En_PEM(A_layer,...
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
    K_eq_til,...
    gamma_til,...
    phi,...
    alpha,...
    sig,...
    LCV,...
    C,...
    q)

air_properties_maine;

%% boolean matrices to select lines
L = eye(8);
L_usx = L(1,:);
L_usy = L(2,:);
L_usz = L(3,:);
L_utz = L(4,:);
L_p = L(8,:);

dL = eye(8);
dL_usx = dL(1,:);
dL_usy = dL(2,:);
dL_usz = dL(3,:);
dL_utz = dL(4,:);

Lmn=eye(6);
Lxx = Lmn(1,:);
Lyy = Lmn(2,:);
Lzz = Lmn(3,:);
Lyz = Lmn(4,:);
Lxz = Lmn(5,:);
Lxy = Lmn(6,:);

%% STRUCTURAL

% e_tilde matrix

e_til_struct=[- 1j*k_x*L_usx;
    - 1j*k_y*L_usy;
    - dL_usz*A_layer;
    (- dL_usy*A_layer - 1j*k_y*L_usz);
    (- dL_usx*A_layer - 1j*k_x*L_usz);
    (- 1j*k_y*L_usx - 1j*k_x*L_usy)]*PHI;


Psi_struct= e_til_struct' * C'  *  e_til_struct ;

%% THERMAL DISSIPATION

e_til_th = - dL_utz*A_layer * PHI;
Psi_p = e_til_th' * K_eq_til' * 1i*omega  * e_til_th ;

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

b_vis = phi.^2 * sig.* ...
    sqrt( eye(3) - 1i*omega* 4*nu_0*rho_0^2.*alpha.^2 / (phi.^2*sig.^2*LCV.^2));

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
prim_allstruct=zeros(8,8);
prim_p=zeros(8,8);
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
        
        % struct diss
        prim_allstruct(ii,jj) = Psi_struct(ii,jj) * int;
        
        % thermal diss
        prim_p (ii,jj) = Psi_p (ii,jj) * int;
        
        % viscous diss
        prim_vis_x (ii,jj) = GAMMA_vis_x (ii,jj) * int;
        prim_vis_y (ii,jj) = GAMMA_vis_y (ii,jj) * int;
        prim_vis_z (ii,jj) = GAMMA_vis_z (ii,jj) * int;
        
        % kinectic pow
        prim_Kx(ii,jj) = Xi_x(ii,jj) * int;
        prim_Ky(ii,jj) = Xi_y(ii,jj) * int;
        prim_Kz(ii,jj) = Xi_z(ii,jj) * int;
        prim_Kfx(ii,jj) = Xi_fx(ii,jj) * int;
        prim_Kfy(ii,jj) = Xi_fy(ii,jj) * int;
        prim_Kfz(ii,jj) = Xi_fz(ii,jj) * int;
    end
end

%% DISSIPATED POWERS

% structural
W_struct =  0.25*real( 1i*omega* q' * prim_allstruct * q );

% thermal
W_th  =  0.25*real(q' * prim_p* q);

%viscous
w_vis_x= real( q' * prim_vis_x* q );
w_vis_y = real( q' * prim_vis_y* q );
w_vis_z = real( q' * prim_vis_z* q );
w_vis = [w_vis_x;w_vis_y;w_vis_z];
% W_vis_x = 0.25*real (omega .* b_vis(1,:) * w_vis ) ;
% W_vis_y = 0.25*real (omega .* b_vis(2,:) * w_vis ) ;
% W_vis_z = 0.25*real (omega .* b_vis(3,:) * w_vis ) ;

W_vis_=  0.25*real (omega .* w_vis ) ;
W_vis_x = W_vis_(1);
W_vis_y = W_vis_(2);
W_vis_z = W_vis_(3);
W_vis= W_vis_x + W_vis_y + W_vis_z ;

% TOTAL POWER

Diss_power =  W_struct +  W_th +  W_vis;

%% Kinetic Energy and Power

% structural nominal
K_x = 0.25*omega^2*rho_1 * real ( q' * prim_Kx * q );
K_y = 0.25*omega^2*rho_1 * real ( q' * prim_Ky * q );
K_z = 0.25*omega^2*rho_1 * real ( q' * prim_Kz * q );
K_struct=K_x+K_y+K_z;

% fluid coupling
Kfc =  0.25*omega^2*  real(rho_12_til)* [ w_vis_x ; w_vis_y ; w_vis_z ];

% fluid total
Kf_x= 0.25*omega^2* rho_2 *  real ( q' * prim_Kfx * q ) + Kfc(1);
Kf_y = 0.25*omega^2* rho_2 *  real ( q' * prim_Kfy * q ) + Kfc(2);
Kf_z = 0.25*omega^2* rho_2 *  real ( q' * prim_Kfz * q ) + Kfc(3);
K_fluid=Kf_x+Kf_y+Kf_z;

Kinetic_energy=K_struct+K_fluid;

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

