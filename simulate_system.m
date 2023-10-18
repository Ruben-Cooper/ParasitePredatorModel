function [X1, X2] = simulate_system(k3, k4, T)
    % Define the differential equations
    ode_system = @(t, y) [y(1)*y(2) - 2*y(1); 
                          k3 - k4*y(2) - 3*y(1)];

    % Initial conditions
    y0 = [1; 1];

    % Integrate
    [t, y] = ode45(ode_system, [0 T], y0);

    X1 = y(end, 1);
    X2 = y(end, 2);
end
