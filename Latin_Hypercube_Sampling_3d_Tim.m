function [k_values] = Latin_Hypercube_Sampling_3d_Tim(bins, k3_range, ...
                                                      k4_range, k5_range)

    k3_bins = linspace(k3_range(1), k3_range(2), bins+1);
    k4_bins = linspace(k4_range(1), k4_range(2), bins+1);
    k5_bins = linspace(k5_range(1), k5_range(2), bins+1);

    remaining_bins_k3 = 1:bins;
    remaining_bins_k4 = 1:bins;
    remaining_bins_k5 = 1:bins;

    k3 = zeros(1,bins);
    k4 = zeros(1,bins);
    k5 = zeros(1,bins);

    for i = 1:bins
        bin1 = randi([1,bins-i+1]);
        bin2 = randi([1,bins-i+1]);
        bin3 = randi([1,bins-i+1]);
        
        k3(i) = k3_bins(remaining_bins_k3(bin1)) + rand*( ...
                k3_bins(remaining_bins_k3(bin1)+1) ...
                - k3_bins(remaining_bins_k3(bin1)));
        remaining_bins_k3(:,bin1) = [];

        k4(i) = k4_bins(remaining_bins_k4(bin2)) + rand*(...
                k4_bins(remaining_bins_k4(bin2)+1) ...
                - k4_bins(remaining_bins_k4(bin2)));
        remaining_bins_k4(:,bin2) = [];

        k5(i) = k5_bins(remaining_bins_k5(bin3)) + rand*(...
                k5_bins(remaining_bins_k5(bin3)+1) ...
                - k5_bins(remaining_bins_k5(bin3)));
        remaining_bins_k5(:,bin3) = [];

    end
    k_values = [k3;k5;k4];
end



