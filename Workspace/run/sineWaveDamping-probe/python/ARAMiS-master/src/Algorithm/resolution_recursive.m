function X_0_moins=resolution_recursive(Omega_0_moins,Omega_0,S)


Mat_wang0=[Omega_0_moins -Omega_0];
det0=det(Mat_wang0);

Mat_wang=Mat_wang0;
Mat_wang(:,1)=S;
X_0_moins(1,1)=det(Mat_wang)/det0;

Mat_wang=Mat_wang0;
Mat_wang(:,2)=S;
X_0_moins(2,1)=det(Mat_wang)/det0;


