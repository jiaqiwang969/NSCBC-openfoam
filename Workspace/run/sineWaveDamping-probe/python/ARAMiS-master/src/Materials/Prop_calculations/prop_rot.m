function [out]=prop_rot(alfa,beta,gamma,in)
    
    rx=[ 1 0 0 ; 0 cos(alfa) sin(alfa) ; 0 -sin(alfa) cos(alfa)];
    ry=[ cos(beta) 0  -sin(beta) ; 0 1 0 ; sin(beta) 0 cos(beta)];
    rz=[cos(gamma) sin(gamma) 0; -sin(gamma) cos(gamma) 0 ; 0 0 1];
    
    R=rx*ry*rz;

    out=R*in*R.';
   

end
