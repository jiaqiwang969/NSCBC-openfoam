function [L,out]=ARAMiS(L,in)

  air_properties_maine;
  co=c_0;
  rho_a=rho_0;
  Po=P_0;
  vis=mu_0;

  in.k_ax=sin(in.theta_1)*cos(in.theta_2); % angle of wave number on x
  in.k_ay=sin(in.theta_1)*sin(in.theta_2); % angle of wave number on y
  in.k_az=sqrt(1-in.k_ax^2-in.k_ay^2);

		       % Calculation of frequency dependent parameters
  ARAMiS_freqpar;

				% CALCULATION OF ALPHA MATRIX
  ARAMiS_alphaconsts;

				% resoution behaviour
  ARAMiS_resolution;

				% wave properties
  ARAMiS_waves;

				% quadratics
  ARAMiS_quadratics;

end

