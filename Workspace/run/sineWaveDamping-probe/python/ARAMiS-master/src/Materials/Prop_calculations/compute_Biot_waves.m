
delta_eq=omega.*sqrt(rho_eq_til./K_eq_til);
delta_s_1=omega.*sqrt(rho_til./P_hat);
delta_s_2=omega.*sqrt(rho_s_til./P_hat);


Psi=((delta_s_2.^2+delta_eq.^2).^2-4*delta_eq.^2.*delta_s_1.^2);
sdelta_total=sqrt(Psi);
delta_1=sqrt(0.5*(delta_s_2.^2+delta_eq.^2+sdelta_total));
delta_2=sqrt(0.5*(delta_s_2.^2+delta_eq.^2-sdelta_total));



mu_1=gamma_til.*delta_eq.^2./(delta_1.^2-delta_eq.^2);
mu_2=gamma_til.*delta_eq.^2./(delta_2.^2-delta_eq.^2);

delta_3=omega.*sqrt(rho_til/N);
mu_3=-gamma_til;

