% Number of samples
n = 500;
samples = lhs2D(n);
Tol = 0.1;

successful_samples_i = [];
successful_samples_ii = [];

for i = 1:n
    [X1, X2] = simulate_system(samples(i, 1), samples(i, 2), 20);

    if X1 >= 0 && X1 <= Tol
        successful_samples_i = [successful_samples_i; samples(i, :)];
    elseif X2 >= (2-Tol) && X2 <= (2+Tol)
        successful_samples_ii = [successful_samples_ii; samples(i, :)];
    end
end

% Visualization
figure;
scatter(successful_samples_i(:, 1), successful_samples_i(:, 2), 'r', 'filled');
hold on;
scatter(successful_samples_ii(:, 1), successful_samples_ii(:, 2), 'b', 'filled');
xlabel('k3');
ylabel('k4');
title('k3 vs k4');
legend('0 <= X1(T) <= 0 + Tol', '2 - Tol <= X2(T) <= 2 + Tol', 'Location', 'southoutside');
