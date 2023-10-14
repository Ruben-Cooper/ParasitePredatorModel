function [k_values] = Orthogonal_Sampling_Tim(bins)

% this needs optimization it works
% could maybe remove 100 lines
% for now it works and distrubutes correctly
% will fully comment later
    range_bins = linspace(0, 0.5, (bins/2)+1);
    upper_range_bins = linspace(0.5, 1, (bins/2)+1);

    remaining_bins_k3 = 1:bins/2;
    upper_remaining_bins_k3 = 1:bins/2;
    remaining_bins_k4 = 1:bins/2;
    upper_remaining_bins_k4 = 1:bins/2;
    remaining_bins_k5 = 1:bins/2;
    upper_remaining_bins_k5 = 1:bins/2;

    k3 = [];
    k4 = [];
    k5 = [];

    lower_used_k3 = 0;
    upper_used_k3 = 0;
    lower_used_k4 = 0;
    upper_used_k4 = 0;
    lower_used_k5 = 0;
    upper_used_k5 = 0;


    for i = 1:bins/8
        bin1 = randi([1,bins/2-lower_used_k3]);
        bin2 = randi([1,bins/2-lower_used_k4]);
        bin3 = randi([1,bins/2-lower_used_k5]);
        
        lower_used_k3 = lower_used_k3 + 1;
        lower_used_k4 = lower_used_k4 + 1;
        lower_used_k5 = lower_used_k5 + 1;

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
        
        bin1 = randi([1,bins/2-upper_used_k3]);
        bin2 = randi([1,bins/2-lower_used_k4]);
        bin3 = randi([1,bins/2-lower_used_k5]);
        
        upper_used_k3 = upper_used_k3 + 1;
        lower_used_k4 = lower_used_k4 + 1;
        lower_used_k5 = lower_used_k5 + 1;

        k3(end+1) = upper_range_bins(upper_remaining_bins_k3(bin1)) + rand*( ...
                  upper_range_bins(upper_remaining_bins_k3(bin1)+1) ...
                  - upper_range_bins(upper_remaining_bins_k3(bin1)));
        upper_remaining_bins_k3(:,bin1) = [];

        k4(end+1) = range_bins(remaining_bins_k4(bin2)) + rand*(...
                  range_bins(remaining_bins_k4(bin2)+1) ...
                  - range_bins(remaining_bins_k4(bin2)));
        remaining_bins_k4(:,bin2) = []; 

        k5(end+1) = range_bins(remaining_bins_k5(bin3)) + rand*(...
                  range_bins(remaining_bins_k5(bin3)+1) ...
                  - range_bins(remaining_bins_k5(bin3)));
        remaining_bins_k5(:,bin3) = [];
        
        bin1 = randi([1,bins/2-lower_used_k3]);
        bin2 = randi([1,bins/2-upper_used_k4]);
        bin3 = randi([1,bins/2-lower_used_k5]);

        lower_used_k3 = lower_used_k3 + 1;
        upper_used_k4 = upper_used_k4 + 1;
        lower_used_k5 = lower_used_k5 + 1;

        k3(end+1) = range_bins(remaining_bins_k3(bin1)) + rand*( ...
                  range_bins(remaining_bins_k3(bin1)+1) ...
                  - range_bins(remaining_bins_k3(bin1)));
        remaining_bins_k3(:,bin1) = [];

        k4(end+1) = upper_range_bins(upper_remaining_bins_k4(bin2)) + rand*(...
                  upper_range_bins(upper_remaining_bins_k4(bin2)+1) ...
                  - upper_range_bins(upper_remaining_bins_k4(bin2)));
        upper_remaining_bins_k4(:,bin2) = []; 

        k5(end+1) = range_bins(remaining_bins_k5(bin3)) + rand*(...
                  range_bins(remaining_bins_k5(bin3)+1) ...
                  - range_bins(remaining_bins_k5(bin3)));
        remaining_bins_k5(:,bin3) = [];
        
        bin1 = randi([1,bins/2-upper_used_k3]);
        bin2 = randi([1,bins/2-upper_used_k4]);
        bin3 = randi([1,bins/2-lower_used_k5]);

        upper_used_k3 = upper_used_k3 + 1;
        upper_used_k4 = upper_used_k4 + 1;
        lower_used_k5 = lower_used_k5 + 1;

        k3(end+1) = upper_range_bins(upper_remaining_bins_k3(bin1)) + rand*( ...
                  upper_range_bins(upper_remaining_bins_k3(bin1)+1) ...
                  - upper_range_bins(upper_remaining_bins_k3(bin1)));
        upper_remaining_bins_k3(:,bin1) = [];

        k4(end+1) = upper_range_bins(upper_remaining_bins_k4(bin2)) + rand*(...
                  upper_range_bins(upper_remaining_bins_k4(bin2)+1) ...
                  - upper_range_bins(upper_remaining_bins_k4(bin2)));
        upper_remaining_bins_k4(:,bin2) = []; 
        
        k5(end+1) = range_bins(remaining_bins_k5(bin3)) + rand*(...
                 range_bins(remaining_bins_k5(bin3)+1) ...
                 - range_bins(remaining_bins_k5(bin3)));
        remaining_bins_k5(:,bin3) = [];
        
        bin1 = randi([1,bins/2-lower_used_k3]);
        bin2 = randi([1,bins/2-lower_used_k4]);
        bin3 = randi([1,bins/2-upper_used_k5]);

        lower_used_k3 = lower_used_k3 + 1;
        lower_used_k4 = lower_used_k4 + 1;
        upper_used_k5 = upper_used_k5 + 1;

        k3(end+1) = range_bins(remaining_bins_k3(bin1)) + rand*( ...
                  range_bins(remaining_bins_k3(bin1)+1) ...
                  - range_bins(remaining_bins_k3(bin1)));
        remaining_bins_k3(:,bin1) = [];

        k4(end+1) = range_bins(remaining_bins_k4(bin2)) + rand*(...
                  range_bins(remaining_bins_k4(bin2)+1) ...
                  - range_bins(remaining_bins_k4(bin2)));
        remaining_bins_k4(:,bin2) = []; 

        k5(end+1) = upper_range_bins(upper_remaining_bins_k5(bin3)) + rand*(...
                  upper_range_bins(upper_remaining_bins_k5(bin3)+1) ...
                  - upper_range_bins(upper_remaining_bins_k5(bin3)));
        upper_remaining_bins_k5(:,bin3) = [];

        bin1 = randi([1,bins/2-upper_used_k3]);
        bin2 = randi([1,bins/2-lower_used_k4]);
        bin3 = randi([1,bins/2-upper_used_k5]);

        upper_used_k3 = upper_used_k3 + 1;
        lower_used_k4 = lower_used_k4 + 1;
        upper_used_k5 = upper_used_k5 + 1;

        k3(end+1) = upper_range_bins(upper_remaining_bins_k3(bin1)) + rand*( ...
                  upper_range_bins(upper_remaining_bins_k3(bin1)+1) ...
                  - upper_range_bins(upper_remaining_bins_k3(bin1)));
        upper_remaining_bins_k3(:,bin1) = [];

        k4(end+1) = range_bins(remaining_bins_k4(bin2)) + rand*(...
                  range_bins(remaining_bins_k4(bin2)+1) ...
                  - range_bins(remaining_bins_k4(bin2)));
        remaining_bins_k4(:,bin2) = []; 

        k5(end+1) = upper_range_bins(upper_remaining_bins_k5(bin3)) + rand*(...
                  upper_range_bins(upper_remaining_bins_k5(bin3)+1) ...
                  - upper_range_bins(upper_remaining_bins_k5(bin3)));
        upper_remaining_bins_k5(:,bin3) = [];
        
        bin1 = randi([1,bins/2-lower_used_k3]);
        bin2 = randi([1,bins/2-upper_used_k4]);
        bin3 = randi([1,bins/2-upper_used_k5]);

        lower_used_k3 = lower_used_k3 + 1;
        upper_used_k4 = upper_used_k4 + 1;
        upper_used_k5 = upper_used_k5 + 1;

        k3(end+1) = range_bins(remaining_bins_k3(bin1)) + rand*( ...
                  range_bins(remaining_bins_k3(bin1)+1) ...
                  - range_bins(remaining_bins_k3(bin1)));
        remaining_bins_k3(:,bin1) = [];

        k4(end+1) = upper_range_bins(upper_remaining_bins_k4(bin2)) + rand*(...
                  upper_range_bins(upper_remaining_bins_k4(bin2)+1) ...
                  - upper_range_bins(upper_remaining_bins_k4(bin2)));
        upper_remaining_bins_k4(:,bin2) = []; 

        k5(end+1) = upper_range_bins(upper_remaining_bins_k5(bin3)) + rand*(...
                  upper_range_bins(upper_remaining_bins_k5(bin3)+1) ...
                  - upper_range_bins(upper_remaining_bins_k5(bin3)));
        upper_remaining_bins_k5(:,bin3) = [];

        bin1 = randi([1,bins/2-upper_used_k3]);
        bin2 = randi([1,bins/2-upper_used_k4]);
        bin3 = randi([1,bins/2-upper_used_k5]);

        upper_used_k3 = upper_used_k3 + 1;
        upper_used_k4 = upper_used_k4 + 1;
        upper_used_k5 = upper_used_k5 + 1;

        k3(end+1) = upper_range_bins(upper_remaining_bins_k3(bin1)) + rand*( ...
                  upper_range_bins(upper_remaining_bins_k3(bin1)+1) ...
                  - upper_range_bins(upper_remaining_bins_k3(bin1)));
        upper_remaining_bins_k3(:,bin1) = [];

        k4(end+1) = upper_range_bins(upper_remaining_bins_k4(bin2)) + rand*(...
                  upper_range_bins(upper_remaining_bins_k4(bin2)+1) ...
                  - upper_range_bins(upper_remaining_bins_k4(bin2)));
        upper_remaining_bins_k4(:,bin2) = []; 

        k5(end+1) = upper_range_bins(upper_remaining_bins_k5(bin3)) + rand*(...
                  upper_range_bins(upper_remaining_bins_k5(bin3)+1) ...
                  - upper_range_bins(upper_remaining_bins_k5(bin3)));
        upper_remaining_bins_k5(:,bin3) = [];
    end
    k_values = [k3;k4;k5];
end