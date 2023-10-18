function [k_values] = Orthogonal_Sampling_Tim(bins)

    % splitting the range into 2 ranges due to Orthogonal into equal
    % sections
    range_bins = [linspace(0, 25, (bins/2)+1);
                  linspace(25, 50, (bins/2)+1);];
    
    % for for looping though the sections
    % determines which range dependent on which section is being sampled
    used_range = [1 1 1;
                  2 1 1;
                  1 2 1;
                  2 2 1;
                  1 1 2;
                  2 1 2;
                  1 2 2;
                  2 2 2;];
    
    % Cell array is used since the size of the inner arrays will be reduced
    % each inner for loop iteration
    remaining_bins = {1:bins/2, 1:bins/2, ...
                      1:bins/2, 1:bins/2, ... 
                      1:bins/2, 1:bins/2,};

    % The counts for how many ranges have been used in each half range
    used = [0 0 0 0 0 0];

    % the order for deciding which section is being sampled from
    using = [1 3 5; 
             2 3 5;
             1 4 5;
             2 4 5;
             1 3 6;
             2 3 6;
             1 4 6;
             2 4 6;];

    % the arrays that store the values
    k3 = [];
    k4 = [];
    k5 = [];


    for i = 1:bins/8
        % This inner loop runs 8 times for each section using the j to
        % access the elements of used_range and using so that the process
        % of sampling the 8 sections can happen over a loop and then outer
        % loop runs this loop again until everthing has been sampled
        % the biggest and only limitation to this approach is that the
        % amount of samples it can generate have to be a multiple of 8
        for j = 1:8
            % generates a random number that will be used as an index for the
            % remaining bins to get the index of what range is being used
            bin1 = randi([1,bins/2-used(using(j,1))]);
            bin2 = randi([1,bins/2-used(using(j,2))]);
            bin3 = randi([1,bins/2-used(using(j,3))]);

            % This is so that when bin1, bin2 and bin3 generates a value it
            % is a valid index
            used(using(j, 1)) = used(using(j, 1))+1;
            used(using(j, 2)) = used(using(j, 2))+1;
            used(using(j, 3)) = used(using(j, 3))+1;

            % generates a random number between the ranges
            k3(end+1) = range_bins(used_range(j,1),...
                        remaining_bins{using(j,1)}(bin1)) + rand*( ...
                        range_bins(used_range(j,1),...
                        remaining_bins{using(j,1)}(bin1)+1) ...
                      - range_bins(used_range(j,1),...
                        remaining_bins{using(j,1)}(bin1)));
            remaining_bins{using(j,1)}(:,bin1) = [];
        
            % generates a random number between the ranges
            k4(end+1) = range_bins(used_range(j,2),...
                        remaining_bins{using(j,2)}(bin2)) + rand*( ...
                        range_bins(used_range(j,2),...
                        remaining_bins{using(j,2)}(bin2)+1) ...
                      - range_bins(used_range(j,2),...
                        remaining_bins{using(j,2)}(bin2)));
            remaining_bins{using(j,2)}(:,bin2) = [];
    
            % generates a random number between the ranges
            k5(end+1) = range_bins(used_range(j,3),...
                        remaining_bins{using(j,3)}(bin3)) + rand*( ...
                        range_bins(used_range(j,3),...
                        remaining_bins{using(j,3)}(bin3)+1) ...
                      - range_bins(used_range(j,3),...
                        remaining_bins{using(j,3)}(bin3)));
            remaining_bins{using(j,3)}(:,bin3) = [];
        end
    end
    % puts all the values into 1 array
    k_values = [k3;k4;k5];
end

