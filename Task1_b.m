% set values for use
initalValues=[1;1;];
finalTime=200;

% simulate using ode45 nothing that for time, direct increments were used
% instead of it doing it for an automatic number of steps
% (for use in comparison to Euler method
[t,solution] = ode45(@(t,y)predpreyFn(t,y,20,4),0:0.01:finalTime,initalValues);

% use of grpahing function
GraphingFn(t,solution,"ODE45 Simulation Method")
