bins = 5;
k3_range = [0 50];
k4_range = [0 50];
k5_range = [0 50];
% the lhs will probably need some adjusting but it seems pretty good
% the only difference between this and the inbuilt is that gives back
% floating point values between (0,1) where as the one i made returns
% integers between the range given and with the amount of bins
% shouldn't really be functionally different just getting values from the
% rands of the inbuilf lhs.
test = Latin_Hypercube_Sampling_3d_Tim(bins, k3_range, k4_range, k5_range);

figure
scatter3(test(1,:),test(2,:),test(3,:))