%% Function for the calculations of the absorption coeeficient


function [abscoeff_out]=absorption_coefficient(R)

abscoeff_out=1-(abs(R).^2);
end


%  Juan Pablo Parra Martinez
%  jppm@kth.se
%  July,2014