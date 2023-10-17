% set parameter values for later use
initalValues=[1;1;];
finalTime=20;

% establish arrays for storing solutions (i'm sorry its a habit)
iscondition1=[];
X1atTAssociated=[];

iscondition2=[];
X2atTAssociated=[];


% simulate process for all even numbers between 0 and 50
for i=0:2:50
    % perform ode for the different k3 values
    [t,solution] = ode45(@(t,y)predpreyFn(t,y,i,4),[0 finalTime],initalValues);
    
    % establish array for storing negative values found in process below
    % reset for each iteration of for loop (each k3 value)
    negatives=[];

    % check for negative values in ode45 simulation 
    % before checking tolerance conditions below

    % for each solution value
    for j=1:length(solution)
        % for Parasite and Food
        for k=1:2
            % check if value is negative
            if(solution(j,k)<0)
                % append to array a value
                negatives=[negatives,1];
            end
        end
    end

    % check if negatives array is not empty (has negatives)
    if(~isempty(negatives))
        % continue to next for loop iteration
        continue;

    % if no negatives, then check for tolerance conditions
    else
        % checks for condition 1 (parasite dies out basically)
        if(solution(end,1)>=0 && solution(end,1)<=0.1)
            % adds k3 value that meets condition 1 to array
            iscondition1=[iscondition1,i];
            % adds the value of Parasite at end of simulation for the 
            % associated k3 value
            X1atTAssociated=[X1atTAssociated,solution(end,1)];
        end
        % food converge level
        if(solution(end,2)>=1.9 && solution(end,2)<=2.1)
            % adds k3 value that meets condition 2 to array
            iscondition2=[iscondition2,i];    
            % adds the value of food at end of simulation for the 
            % associated k3 value
            X2atTAssociated=[X2atTAssociated,solution(end,2)];
        end
    end

end

% plotting
plot(iscondition1,X1atTAssociated,'r.')
hold on
plot(iscondition2,X2atTAssociated,'b.')
hold on
yline(0.1,'k')
hold on
hold on
yline(1.9,'k')
hold on
xlim([0,50])
ylim([0,2.1])
ylabel('X_n(T)')
title("Parameter Sweep of k_3 and the resulting X_n values at T=20")
xlabel("k_3")
xticks(0:2:50)
legend("Scenario i for n=1","Scenario ii for n=2","Scenario Boundaries",Location="best")
