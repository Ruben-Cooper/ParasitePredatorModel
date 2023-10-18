function [k_values] = Latin_Hypercube_Sampling_3d_Tim(samples)

    % the ranges for each sample
    % since all values are from 0 to 50 the same array of ranges is used
    % the +1 to the samples makes it so there the function will return the
    % amount of samples specified
    range_bins = linspace(0, 50, samples+1);
    
    % since for the LHS the sampled values are indpendent from each other
    % e.g. k3 only affects k3 and the remaining ranges that can be used for
    % k3 and does not affect the other 2
    remaining_bins_k3 = 1:samples;
    remaining_bins_k4 = 1:samples;
    remaining_bins_k5 = 1:samples;

    % the arrays that store the values
    k3 = [];
    k4 = [];
    k5 = [];

    for i = 1:samples
        % generates a random number that will be used as an index for the
        % remaining bins to get the index of what range is being used
        bin1 = randi([1,samples-i+1]);
        bin2 = randi([1,samples-i+1]);
        bin3 = randi([1,samples-i+1]);
        
        % generates a random number between the ranges
        k3(end+1) = range_bins(remaining_bins_k3(bin1)) + rand*( ...
                range_bins(remaining_bins_k3(bin1)+1) ...
                - range_bins(remaining_bins_k3(bin1)));
        % removes the index just used for this sample
        remaining_bins_k3(:,bin1) = [];

        % generates a random number between the ranges
        k4(end+1) = range_bins(remaining_bins_k4(bin2)) + rand*(...
                range_bins(remaining_bins_k4(bin2)+1) ...
                - range_bins(remaining_bins_k4(bin2)));
        % removes the index just used for this sample
        remaining_bins_k4(:,bin2) = [];

        % generates a random number between the ranges
        k5(end+1) = range_bins(remaining_bins_k5(bin3)) + rand*(...
                range_bins(remaining_bins_k5(bin3)+1) ...
                - range_bins(remaining_bins_k5(bin3)));
        % removes the index just used for this sample
        remaining_bins_k5(:,bin3) = [];

    end
    % puts all the values into 1 array
    k_values = [k3;k4;k5];
end



