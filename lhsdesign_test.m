% Number of samples
n = 500;

% Generate LHS samples using lhsdesign
lhs_samples = lhsdesign(n, 2); 

% Scale the samples to the range [0, 50]
lhs_samples = lhs_samples * 50; 

successful_samples_i = [];
successful_samples_ii = [];

for i = 1:n
    [X1, X2] = simulate_system(lhs_samples(i, 1), lhs_samples(i, 2), 20);

    if X1 >= 0 && X1 <= Tol
        successful_samples_i = [successful_samples_i; lhs_samples(i, :)];
    elseif X2 >= (2-Tol) && X2 <= (2+Tol)
        successful_samples_ii = [successful_samples_ii; lhs_samples(i, :)];
    end
end

% Visualization
figure;
scatter(successful_samples_i(:, 1), successful_samples_i(:, 2), 'r', 'filled');
hold on;
scatter(successful_samples_ii(:, 1), successful_samples_ii(:, 2), 'b', 'filled');
xlabel('k3');
ylabel('k4');
title('Parameter Regions based on System Dynamics');
legend('0 <= X1(T) <= 0 + Tol', '2 - Tol <= X2(T) <= 2 + Tol', 'Location', 'southoutside');