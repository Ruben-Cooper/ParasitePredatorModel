% set parameter values for later
initalValues=[1;1;];
finalTime=20;

% establishing arrays for storing the k3 and k4 pairs for 
% both Parasite and Food (habit sorry)
iscondition1k3=[];
iscondition1k4=[];
iscondition2k3=[];
iscondition2k4=[];


% simulate for every even number between 0 and 50 for k3
for i=0:2:50
    % simulate for every nuber between 
    for L=0:50
    % run ode simulation    
    [t,solution] = ode45(@(t,y)predpreyFn(t,y,i,L),[0 finalTime],initalValues);
    
    % establish array for storing negative values found in process below
    % reset for each iteration of for loop (each (k3,k4) value pair)
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
            % store pair of k3 and k4 that met condition 1
            iscondition1k3=[iscondition1k3,i];
            iscondition1k4=[iscondition1k4,L];
        end
        % food converge level
        if(solution(end,2)>=1.9 && solution(end,2)<=2.1)
            % store pair of k3 and k4 that met condition 2
            iscondition2k3=[iscondition2k3,i];
            iscondition2k4=[iscondition2k4,L];
        end
    end
    end

end

% plotting
plot(iscondition1k3,iscondition1k4,'b.')
hold on
plot(iscondition2k3,iscondition2k4,'r.')
xlim([0,51])
ylim([0,51])
title("(k_3,k_4) Paired Parameter Sweep")
xlabel("k_3")
xticks([0:2:50])
ylabel('k_4')
yticks([0:5:50])
legend("Scenario i","Scenario ii",Location="southoutside")