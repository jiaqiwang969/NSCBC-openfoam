clc;
clear;

numProbes = 11;
path="/Users/wjq/Documents/05-NSCBC/Workspace/run/sineWaveDampingLusgsFoam-backward/postProcessing/probes/0/";
idU = fopen(path+'U','r');
tU = textscan(idU,'%f','Delimiter',{'(',')',' '},'MultipleDelimsAsOne',true,'headerlines',numProbes+2);
fclose(idU);
idp = fopen(path+'p','r');
tp = textscan(idp,'%f','Delimiter',{'(',')',' '},'MultipleDelimsAsOne',true,'headerlines',numProbes+2);
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


p1 = outData_p.probe1;
U1 = outData_U.probe1;
p2 = outData_p.probe2;
U2 = outData_U.probe2;
p3 = outData_p.probe3;
U3 = outData_U.probe3;
p4 = outData_p.probe4;
U4 = outData_U.probe4;
p5 = outData_p.probe5;
U5 = outData_U.probe5;
p6 = outData_p.probe6;
U6 = outData_U.probe6;
p7 = outData_p.probe7;
U7 = outData_U.probe7;
p8 = outData_p.probe8;
U8 = outData_U.probe8;
p9 = outData_p.probe9;
U9 = outData_U.probe9;
p10 = outData_p.probe10;
U10 = outData_U.probe10;
p11 = outData_p.probe11;
U11 = outData_U.probe11;

figure
plot(p1/mean(p1))
hold on
plot(p2/mean(p2))
hold on
plot(p3/mean(p3))
hold on
plot(p4/mean(p4))
hold on
plot(p5/mean(p5))
hold on
plot(p6/mean(p6))
hold on
plot(p7/mean(p7))
hold on
plot(p8/mean(p8))
hold on
plot(p9/mean(p9))
hold on
plot(p10/mean(p10))
hold on
plot(p11/mean(p11))

figure
plot(U1/mean(U1))
hold on
plot(U2/mean(U2))
hold on
plot(U3/mean(U3))
hold on
plot(U4/mean(U4))
hold on
plot(U5/mean(U5))
hold on
plot(U6/mean(U6))
hold on
plot(U7/mean(U7))
hold on
plot(U8/mean(U8))
hold on
plot(U9/mean(U9))
hold on
plot(U10/mean(U10))
hold on
plot(U11/mean(U11))


  