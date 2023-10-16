% set fixed variables
h=0.01;
t=20;

% calculate number of steps
steps=t/h;

% set changable variables
k3=20;
k4=4;


% create empty arrays for parasite and food values (plus one to account for
% the fact matlab starts at 1 not 0 with arrays
X1=zeros(steps+1,1);
X2=zeros(steps+1,1);

%set initial values in arrays
X1(1)=1;
X2(1)=1;

% run loop for each step in simulation
for i=2:steps+1
    % Derived explicit Euler method formula for Parasite
    X1(i)=X1(i-1)*(0.98+0.01*X2(i-1));
    % Derived explicit Euler method formula for Food
    X2(i)=X2(i-1)-0.01*X2(i-1)*k4+0.01*k3-0.03*X1(i-1);
end

% create t variable with appropriate intervals for graphing
t=0:h:t;

% use of Graphing Function
GraphingFn(t,[X1,X2],"Explicit Euler Method Simulation")
