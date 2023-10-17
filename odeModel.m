function dZ_dt = odeModel(t,z,k_values)
    X1=z(1);
    X2=z(2);

    dX1dt=X1*X2-2*X1;
    dX2dt=k_values(1)-k_values(2)*X2-k_values(3)*X1;
    dZ_dt=[dX1dt;dX2dt];
end