% before running this, run task1 a and b

% Combine the predator and pray into one array for ease of use
combined= [X1 X2];


% set up difference arrays 
rel_diff=zeros(2001,2);
test=zeros(2001,2);

for i=1:2001
    for j=1:2
        % relative difference as a percent of euler to ode45
        rel_diff(i,j)=(combined(i,j)-solution(i,j))/solution(i,j)*100;
    end

end

% Finding average of difference between euler method and ode45 method for
% parasite and food
X1diff=mean(rel_diff(:,1));
X2diff=mean(rel_diff(:,2));