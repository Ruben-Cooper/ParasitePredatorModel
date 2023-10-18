function samples = lhs2D(n)
    % n is the number of samples
    % Initialize the matrix to store the samples.
    samples = zeros(n, 2);

    % Generate random permutations for k3 and k4
    % This ensures that each segment of the parameter space is sampled once.
    p_k3 = randperm(n);
    p_k4 = randperm(n);

    for i = 1:n
        % Generate a random number within the stratum
        samples(i, 1) = (p_k3(i) - rand()) / n * 50; % k3 & k4 value in range [0,50]
        samples(i, 2) = (p_k4(i) - rand()) / n * 50;
    end
end
