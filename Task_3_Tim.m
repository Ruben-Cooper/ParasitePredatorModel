bins = 24;
% the lhs will probably need some adjusting but it seems pretty good
% the only difference between this and the inbuilt is that gives back
% floating point values between (0,1) i can get the same result by making
% the ranges [0 1] but having be any range better in the long run
% shouldn't really be functionally different just getting values from the
% rands of the inbuilf lhs.
lhs_results = Latin_Hypercube_Sampling_3d_Tim(bins);

% orthogonal needs so optimization but it works as intended but only for
% bins sizes divisible by 8 since it equally splits the 3d apce into 8
% cubes
Orthogonal_results = Orthogonal_Sampling_Tim(bins);

X0 = [1;1;];
T = 20;
Tol = 0.1;

lhs_c1 = double.empty(0,3);
orth_c1 = double.empty(0,3);
lhs_c2 = double.empty(0,3);
orth_c2 = double.empty(0,3);

lhs_c1_ammount = 0;
lhs_c2_ammount = 0;
orth_c1_ammount = 0;
orth_c2_ammount = 0;

for i = 1:bins

    [t,final_lhs] = ode45(@(t,z)odeModel(t,z,lhs_results(:,i)),[0 T],X0);
    
    for j = 1:length(final_lhs)
        if(final_lhs(j,1)<0||final_lhs(j,2)<0)
            continue;
        end
    end

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

for i = 1:bins

    [t,final_orth] = ode45(@(t,z)odeModel(t,z,Orthogonal_results(:,i)),[0 T],X0);
    
    for j = 1:length(final_orth)
        if(final_orth(j,1)<0||final_orth(j,2)<0)
            continue;
        end
    end

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


figure
scatter3(lhs_c1(:,1),lhs_c1(:,2),lhs_c1(:,3))
figure
scatter3(lhs_c2(:,1),lhs_c2(:,2),lhs_c2(:,3))
figure
scatter3(orth_c1(:,1),orth_c1(:,2),orth_c1(:,3))
figure
scatter3(orth_c2(:,1),orth_c2(:,2),orth_c2(:,3))