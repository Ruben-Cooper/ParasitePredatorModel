% the amount of samples
samples = 800;

% LHS values
lhs_results = Latin_Hypercube_Sampling_3d_Tim(samples);

% the orthogonal sampler only allows multiples of eight 
Orthogonal_results = Orthogonal_Sampling_Tim(samples);

% setting intial parameters
X0 = [1;1;];
T = 20;
Tol = 0.1;

% creating the 3 row empty arrays to store the points that meet the
% condition for both samplers
lhs_c1 = double.empty(0,3);
orth_c1 = double.empty(0,3);
lhs_c2 = double.empty(0,3);
orth_c2 = double.empty(0,3);

% These values are set so that k3,k4 and k5 can be saved into the empty
% arrays
lhs_c1_ammount = 0;
lhs_c2_ammount = 0;
orth_c1_ammount = 0;
orth_c2_ammount = 0;

% testing the 3d LHS
for i = 1:samples
    negs = 0;
    % solves the ode
    [t,final_lhs] = ode45(@(t,z)odeModel(t,z,lhs_results(:,i)),[0 T],X0);
    
    % checks if X1 or X2 is negative and on the first occurance the loop
    % will go to the next iteration
    for j = 1:length(final_lhs)
        if(final_lhs(j,1)<0||final_lhs(j,2)<0)
            negs = negs+1;
            break;
        end
    end
    if (~negs==0)
        continue;
    end

    % if X1 and X2 had no negatives condition 1 and 2 are checked
    % if they meet that conditions the k values get saved
    if(final_lhs(end,1)>=0 && final_lhs(end,1)<=Tol)
        lhs_c1_ammount = lhs_c1_ammount + 1;
        lhs_c1(lhs_c1_ammount,1) = lhs_results(1,i);
        lhs_c1(lhs_c1_ammount,2) = lhs_results(2,i);
        lhs_c1(lhs_c1_ammount,3) = lhs_results(3,i);
    end

    if(final_lhs(end,2)>=(2-Tol) && final_lhs(end,2)<=(2+Tol))
        lhs_c2_ammount = lhs_c2_ammount + 1;
        lhs_c2(lhs_c2_ammount,1) = lhs_results(1,i);
        lhs_c2(lhs_c2_ammount,2) = lhs_results(2,i);
        lhs_c2(lhs_c2_ammount,3) = lhs_results(3,i);
    end
end

% testing the Orthogonal sampler
for i = 1:samples
    negs = 0;
    % solves the ode
    [t,final_orth] = ode45(@(t,z)odeModel(t,z,Orthogonal_results(:,i)),[0 T],X0);
    
    % checks if X1 or X2 is negative and on the first occurance the loop
    % this loop will end
    for j = 1:length(final_orth)
        if(final_orth(j,1)<0||final_orth(j,2)<0)
            negs = negs+1;
            break;
        end
    end
    % checks if negative is found the loop will go to the next iteration
    if (~negs==0)
        continue;
    end

    % if X1 and X2 had no negatives condition 1 and 2 are checked
    % if they meet that conditions the k values get saved
    if(final_orth(end,1)>=0 && final_orth(end,1)<=Tol)
        orth_c1_ammount = orth_c1_ammount + 1;
        orth_c1(orth_c1_ammount,1) = Orthogonal_results(1,i);
        orth_c1(orth_c1_ammount,2) = Orthogonal_results(2,i);
        orth_c1(orth_c1_ammount,3) = Orthogonal_results(3,i);
    end

    if(final_orth(end,2)>=(2-Tol) && final_orth(end,2)<=(2+Tol))
        orth_c2_ammount = orth_c2_ammount + 1;
        orth_c2(orth_c2_ammount,1) = Orthogonal_results(1,i);
        orth_c2(orth_c2_ammount,2) = Orthogonal_results(2,i);
        orth_c2(orth_c2_ammount,3) = Orthogonal_results(3,i);
    end
end


% plotting as a 3d scatter plot 
figure
scatter3(lhs_c1(:,1),lhs_c1(:,2),lhs_c1(:,3))
xlabel('k3')
ylabel('k4')
zlabel('k5')
title('3D LHS values that meet condition 1')
xlim([0 50])
ylim([0 50])
zlim([0 50])

figure
scatter3(lhs_c2(:,1),lhs_c2(:,2),lhs_c2(:,3))
xlabel('k3')
ylabel('k4')
zlabel('k5')
title('3D LHS values that meet condition 2')
xlim([0 50])
ylim([0 50])
zlim([0 50])

figure
scatter3(orth_c1(:,1),orth_c1(:,2),orth_c1(:,3))
xlabel('k3')
ylabel('k4')
zlabel('k5')
title('Orthogonal sampler values that meet condition 1')
xlim([0 50])
ylim([0 50])
zlim([0 50])

figure
scatter3(orth_c2(:,1),orth_c2(:,2),orth_c2(:,3))
xlabel('k3')
ylabel('k4')
zlabel('k5')
title('Orthogonal sampler values that meet condition 2')
xlim([0 50])
ylim([0 50])
zlim([0 50])



