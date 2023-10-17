function [k_values] = Orthogonal_Sampling_Tim(bins)

% this needs optimization it works
% could maybe remove 100 lines
% for now it works and distrubutes correctly
% will fully comment later
    range_bins = [linspace(0, 25, (bins/2)+1);
                  linspace(25, 50, (bins/2)+1);];
    
    used_range = [1 1 1;
                  2 1 1;
                  1 2 1;
                  2 2 1;
                  1 1 2;
                  2 1 2;
                  1 2 2;
                  2 2 2;];

    remaining_bins = {1:bins/2, 1:bins/2, ...
                      1:bins/2, 1:bins/2, ... 
                      1:bins/2, 1:bins/2,};

    k3 = [];
    k4 = [];
    k5 = [];

    used = [0 0 0 0 0 0];

    using = [1 3 5; 
             2 3 5;
             1 4 5;
             2 4 5;
             1 3 6;
             2 3 6;
             1 4 6;
             2 4 6;];


    for i = 1:bins/8
        for j = 1:8
            bin1 = randi([1,bins/2-used(using(j,1))]);
            bin2 = randi([1,bins/2-used(using(j,2))]);
            bin3 = randi([1,bins/2-used(using(j,3))]);

            used(using(j, 1)) = used(using(j, 1))+1;
            used(using(j, 2)) = used(using(j, 2))+1;
            used(using(j, 3)) = used(using(j, 3))+1;
            k3(end+1) = range_bins(used_range(j,1),...
                        remaining_bins{using(j,1)}(bin1)) + rand*( ...
                        range_bins(used_range(j,1),...
                        remaining_bins{using(j,1)}(bin1)+1) ...
                      - range_bins(used_range(j,1),...
                        remaining_bins{using(j,1)}(bin1)));
            remaining_bins{using(j,1)}(:,bin1) = [];
        
            k4(end+1) = range_bins(used_range(j,2),...
                        remaining_bins{using(j,2)}(bin2)) + rand*( ...
                        range_bins(used_range(j,2),...
                        remaining_bins{using(j,2)}(bin2)+1) ...
                      - range_bins(used_range(j,2),...
                        remaining_bins{using(j,2)}(bin2)));
            remaining_bins{using(j,2)}(:,bin2) = [];
    
            k5(end+1) = range_bins(used_range(j,3),...
                        remaining_bins{using(j,3)}(bin3)) + rand*( ...
                        range_bins(used_range(j,3),...
                        remaining_bins{using(j,3)}(bin3)+1) ...
                      - range_bins(used_range(j,3),...
                        remaining_bins{using(j,3)}(bin3)));
            remaining_bins{using(j,3)}(:,bin3) = [];
        end
    end
    k_values = [k3;k4;k5];
end