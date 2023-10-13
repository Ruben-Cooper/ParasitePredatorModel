bins = 5;
k3_range = [0 50];
k4_range = [0 50];
k5_range = [0 50];
% the lhs will probably need some adjusting but it seems pretty good
% the only difference between this and the inbuilt is that gives back
% floating point values between (0,1) i can get the same result by making
% the ranges [0 1] but having be any range better in the long run
% shouldn't really be functionally different just getting values from the
% rands of the inbuilf lhs.
test = Latin_Hypercube_Sampling_3d_Tim(bins, k3_range, k4_range, k5_range);

figure
scatter3(test(1,:),test(2,:),test(3,:))