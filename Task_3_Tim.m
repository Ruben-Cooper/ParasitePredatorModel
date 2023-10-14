bins = 24;
% the lhs will probably need some adjusting but it seems pretty good
% the only difference between this and the inbuilt is that gives back
% floating point values between (0,1) i can get the same result by making
% the ranges [0 1] but having be any range better in the long run
% shouldn't really be functionally different just getting values from the
% rands of the inbuilf lhs.
lhs_test = Latin_Hypercube_Sampling_3d_Tim(bins);



figure
scatter3(lhs_test(1,:),lhs_test(2,:),lhs_test(3,:))

%%
% orthogonal needs so optimization but it works as intended but only for
% bins sizes divisible by 8 since it equally splits the 3d apce into 8
% cubes
bins = 24;
Orthogonal_test = Orthogonal_Sampling_Tim(bins);

figure
scatter3(Orthogonal_test(1,:),Orthogonal_test(2,:),Orthogonal_test(3,:))