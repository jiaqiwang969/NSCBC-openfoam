function [xp,yp,zp]=plotsys_pg(vxp,vyp,vzp,laynr)
%

figure(100)
grid on

unitx=[0 0 0; 1 0 0];
unity=[0 0 0; 0 1 0];
unitz=[0 0 0; 0 0 1];
%
plsym=['r:';'g:';'k:';'r-';'g-';'k-'];
adsym=3*(laynr-1)+1;
%
unitxp=vxp/sqrt((vxp*vxp'));
unityp=vyp/sqrt((vyp*vyp'));
unitzp=vzp/sqrt((vzp*vzp'));
%
set(gca,'FontSize',14)
plot3(unitx(1:2,1),unitx(1:2,2),unitx(1:2,3),'-','LineWidth',1)
hold on
plot3(unity(1:2,1),unity(1:2,2),unity(1:2,3),'-','LineWidth',1)
%hold on
plot3(unitz(1:2,1),unitz(1:2,2),unitz(1:2,3),'-','LineWidth',1)
%hold on
%
xp=[0 0 0; unitxp(1),unitxp(2),unitxp(3)] ;
plot3(xp(1:2,1),xp(1:2,2),xp(1:2,3),plsym(adsym,1:2),'LineWidth',2)
%hold on
yp=[0 0 0; unityp(1),unityp(2),unityp(3)] ;
plot3(yp(1:2,1),yp(1:2,2),yp(1:2,3),plsym(adsym+1,1:2),'LineWidth',2)
%hold on
zp=[0 0 0; unitzp(1),unitzp(2),unitzp(3)] ;
plot3(zp(1:2,1),zp(1:2,2),zp(1:2,3),plsym(adsym+2,1:2),'LineWidth',2)
%hold on
legend('Layer 1',' ',' ', 'Layer 2')
xlabel('x')
ylabel('y')
zlabel('z')
axis([-1 1 -1 1 -1 1])
