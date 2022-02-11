%% Function for the calculation of the Transmission loss in dB


function [TL]=TL(in)

TL=-20.*log10(abs(in));

end

%  Juan Pablo Parra Martinez
%  jppm@kth.se
%  July,2014