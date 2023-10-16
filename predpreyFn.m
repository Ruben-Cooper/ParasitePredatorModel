function dZ_dt = predpreyFn(t,y,k3,k4)

X1=y(1);
X2=y(2);

dX1_dt=X1*X2-2*X1;
dX2_dt=k3-k4*X2-3*X1;

dZ_dt=[dX1_dt;dX2_dt];

end