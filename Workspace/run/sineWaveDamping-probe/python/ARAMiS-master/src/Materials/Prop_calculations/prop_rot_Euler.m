function [out]=prop_rot_Euler(alfa,beta,gamma,in,ipl)
    
    rx=[ 1 0 0 ; 0 cos(alfa) sin(alfa) ; 0 -sin(alfa) cos(alfa)];
    ry=[ cos(beta) 0  -sin(beta) ; 0 1 0 ; sin(beta) 0 cos(beta)];
    rz=[cos(gamma) sin(gamma) 0; -sin(gamma) cos(gamma) 0 ; 0 0 1];
    
    R=rz*ry*rx;
    
    ilay=1;
    xeig=R(1:3,1)';
    yeig=R(1:3,2)';
    zeig=R(1:3,3)';
    if ipl == 1
        plotsys_pg(xeig,yeig,zeig,ilay);
    end
                             
    
    out=R*in*R.';
   

end
