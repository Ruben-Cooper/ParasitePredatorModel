function [k_values] = Latin_Hypercube_Sampling_3d_Tim(bins)

% will fully comment later
    range_bins = linspace(0, 1, bins+1);

    remaining_bins_k3 = 1:bins;
    remaining_bins_k4 = 1:bins;
    remaining_bins_k5 = 1:bins;

    k3 = [];
    k4 = [];
    k5 = [];

    for i = 1:bins
        bin1 = randi([1,bins-i+1]);
        bin2 = randi([1,bins-i+1]);
        bin3 = randi([1,bins-i+1]);
        
        k3(end+1) = range_bins(remaining_bins_k3(bin1)) + rand*( ...
                range_bins(remaining_bins_k3(bin1)+1) ...
                - range_bins(remaining_bins_k3(bin1)));
        remaining_bins_k3(:,bin1) = [];

        k4(end+1) = range_bins(remaining_bins_k4(bin2)) + rand*(...
                range_bins(remaining_bins_k4(bin2)+1) ...
                - range_bins(remaining_bins_k4(bin2)));
        remaining_bins_k4(:,bin2) = [];

        k5(end+1) = range_bins(remaining_bins_k5(bin3)) + rand*(...
                range_bins(remaining_bins_k5(bin3)+1) ...
                - range_bins(remaining_bins_k5(bin3)));
        remaining_bins_k5(:,bin3) = [];

    end
    k_values = [k3;k4;k5];
end



