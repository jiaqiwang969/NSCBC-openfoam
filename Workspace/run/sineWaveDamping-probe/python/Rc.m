clc;
clear;

numProbes = 1;
path="~/Documents/05-NSCBC/Workspace/run/sineWaveDamping-probe/postProcessing/probes/0/";

idU = fopen(path+'U','r');
tU = textscan(idU,'%f','Delimiter',{'(',')',' '},'MultipleDelimsAsOne',true,'headerlines',3);
fclose(idU);
idp = fopen(path+'p','r');
tp = textscan(idp,'%f','Delimiter',{'(',')',' '},'MultipleDelimsAsOne',true,'headerlines',3);
fclose(idp);

tempU = reshape(tU{1},numProbes*3+1,[]);
tempp = reshape(tp{1},numProbes*1+1,[]);


outData_U.time = tempU(1,:).';
for ii = 1:numProbes
    rowIdxU = (ii-1)*3+2:(ii-1)*3+4;
    outData_U.(num2str(ii,'probe%d')) = tempU(rowIdxU,:).';
end

outData_p.time = tempp(1,:).';
for ii = 1:numProbes
    rowIdxp = (ii-1)*1+2:(ii-1)*1+2;
    outData_p.(num2str(ii,'probe%d')) = tempp(rowIdxp,:).';
end

clear rowIdxp rowIdxU tempp tempU tp tU ii idp idU


p = outData_p.probe1;
U = outData_U.probe1;

figure
plot(p/max(p))
hold on
plot(U/max(U))



A_f(:,i)=0.5*


% Declaration of the matrices/values used for FFT
t = outData_p.time;
L = length(outData_p.time); % 无需给出这么细密的时间步
Fs = 1/t(1);  %sampling frequency
T = 1/Fs;  %period of sampling
f = Fs*(0:(L/2))/L;
%max_A = zeros(s,3);

% Declaration of the matrice for the acoustic part of velocity/pressure
% Start of the mean-value calculation
UA = zeros(1,71);
pA = zeros(1,71);
meanValue = 95000;

% Calculating the acoustic fluctuation of pressure and velocity for every
% cell
% Time-steps written into the acoustic part of velocity/pressure in the
% first column 
for i = 2:71
    UA(:,1) = UWall(:,1);
    UA(:,i) = UWall(:,(2+(i-2)*3)) - mean(UWall(meanValue:(meanValue+L),(2+(i-2)*3)));
    pA(:,1) = pWall(:,1);
    pA(:,i) = pWall(:,i) - mean(pWall(meanValue:(meanValue+L),i));
    
    % Taking only the last time steps; nearly converged state
    A_ff(:,i) = A_f(95000:99286,i);
    A_gg(:,i) = A_g(95000:99286,i);

    % Fast Fourier Transformation of f and g wave
    Y_f(:,i) = fft(A_ff(:,i));
    P2f(:,i) = abs(Y_f(:,i)/L);
    P1f(:,i) = P2f(1:(L/2)+1,i);
    P1f(2:end-1,i) = 2*P1f(2:end-1,i);
    Y_g(:,i) = fft(A_gg(:,i));
    P2g(:,i) = abs(Y_g(:,i)/L);
    P1g(:,i) = P2g(1:(L/2)+1,i);
    P1g(2:end-1,i) = 2*P1g(2:end-1,i);

    %Calculating the wall distance for every cell
    distance(i,2) = distance(1,1) - distance(i,1);

    %Identify the max amplitude value for the frequency F=700 hz
    max_temp_f = max(P1f(4,i));
    max_A(i,1) = max_temp_f;      %max f
    max_temp_g = max(P1g(4,i));
    max_A(i,2) = max_temp_g;      %max g
    max_A(i,3) = max_temp_g / max_temp_f; % Rc
end

%Save the maximum amplitude of f and g wave and the refered Rc
Rc = [distance(:,2), max_A];
    