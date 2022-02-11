%% Function for the calculations of the Hooke's tensor for an isotropic material
% (no damping included as it depends on elastic or anelastic models)

function [C]=hookes_iso(Lame1,Lame2)

C=zeros(6,6);
C(1,:)=[2*Lame2+Lame1 Lame1 Lame1 0 0 0];
C(2,:)=[Lame1 2*Lame2+Lame1 Lame1 0 0 0];
C(3,:)=[Lame1 Lame1 2*Lame2+Lame1 0 0 0];
C(4,4)=2*Lame2;
C(5,5)=2*Lame2;
C(6,6)=2*Lame2;

end

%  Juan Pablo Parra Martinez
%  jppm@kth.se
%  July,2014

