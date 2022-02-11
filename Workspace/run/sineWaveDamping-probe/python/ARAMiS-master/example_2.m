%% EXAMPLE: Multilayered system.
%% Author: Juan Parra
%% Email: jppm@kth.se
%% Date: 2020-11-06
%% License: GNU LGPL 3.0

clear all
addpath(genpath('./src/'))

%% Constants
air_properties_maine;		% Load properties of air
global L in out

%%% INPUTS
%% Definition of the frequency domain
fmin=16;			% initial frequency
fmax=8000;			% last frequency
fnb=200;				% amount of frequencies
in.f=logspace(log10(fmin),log10(fmax),fnb);	% linear discretization of the frequency space

%% Definition o the plane wave incidence
% solid_stroh is singular for theta_1=0 deg, so approximation needed
in.theta_1= 20 *pi/180; % angle z0x
in.theta_2=1e-3*pi/180; % angle x0y

%% Termination
in.termination='transmission';

%%% MATERIAL LAYERS
%% Layer 1
L(1).d=2e-3;			% Thickness of the layer
L(1).material.type='solid';	% 'pem' for poroelastic media
L(1).material.sheet='mat_aluminium';

%% Layer 2
L(2).d=50e-3;			% Thickness of the layer
L(2).material.type='pem';	% 'pem' for poroelastic media
L(2).material.sheet='mat_PEM2';
L(2).material.rotation=1;  %% 1 == no // 2 == si

%% Layer 3
L(3).d=1e-3;
L(3).material.type='fluid';
L(3).material.sheet='air_properties_maine';

%% Layer 4
L(4) = L(1);

%%% OUTPUT
%% Resolution protocol. DO NOT CHANGE
[L,out]=ARAMiS(L,in);


%% Example plot
subplot(211)
semilogx(in.f,out.TL)
xlabel('Frequency (Hz)')
ylabel('Sound Transmission Loss (dB)')
ylim([0,100])

subplot(212)
loglog(in.f,abs(L(2).kinpow.tot))
xlabel('Frequency (Hz)')
ylabel('Total kinetic power (W/m2)')
