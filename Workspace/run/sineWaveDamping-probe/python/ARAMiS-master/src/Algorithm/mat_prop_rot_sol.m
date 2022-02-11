function [C]=mat_prop_rot_sol(alfa,beta,gamma,C_i)
    
    rx=[ 1 0 0 ; 0 cos(gamma) -sin(gamma) ; 0 sin(gamma) cos(gamma)];
    ry=[ cos(beta) 0  sin(beta) ; 0 1 0 ; -sin(beta) 0 cos(beta)];
    rz=[cos(alfa) -sin(alfa) 0; sin(alfa) cos(alfa) 0 ; 0 0 1];
    
    R=rx*ry*rz;
    
        RC_11=R.^2;
        
        RC_21=[R(2,1)*R(3,1) R(2,2)*R(3,2) R(2,3)*R(3,3);
                R(1,1)*R(3,1) R(1,2)*R(3,2) R(1,3)*R(3,3);
                R(1,1)*R(2,1) R(1,2)*R(2,2) R(1,3)*R(2,3);];
            
        RC_12= 2.*[R(1,2)*R(1,3) R(1,1)*R(1,3) R(1,1)*R(1,2);
                    R(2,2)*R(2,3) R(2,1)*R(2,3) R(2,1)*R(2,2);
                    R(3,2)*R(3,3) R(3,1)*R(3,3) R(3,1)*R(3,2);];
                
        RC_22=[R(2,2)*R(3,3)+R(2,3)*R(3,2)  R(2,1)*R(3,3)+R(2,3)*R(3,1)  R(2,1)*R(3,2)+R(2,2)*R(3,1);
                R(1,2)*R(3,3)+R(1,3)*R(3,2)  R(1,1)*R(3,3)+R(1,3)*R(3,1)  R(1,1)*R(3,2)+R(1,2)*R(3,1);
                R(1,2)*R(2,3)+R(1,3)*R(2,2)  R(1,1)*R(2,3)+R(1,3)*R(2,1)  R(1,1)*R(2,2)+R(1,2)*R(2,1);];
                            
   RC=[RC_11 RC_12 ; RC_21 RC_22];
    
    C=inv(RC)*C_i*RC;
    
end