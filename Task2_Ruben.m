% Number of samples
n = 500;
samples = lhs2D(n);
Tol = 0.1;

% Initialise empty matrices to store successful samples for both cases
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

% Create Scatter Plot Visualisation
figure;
scatter(successful_samples_i(:, 1), successful_samples_i(:, 2), 'r', 'filled');
hold on;
scatter(successful_samples_ii(:, 1), successful_samples_ii(:, 2), 'b', 'filled');

% Plotting the boundry line
x_vals = linspace(0, 50, 1000);  % Generating 1000 points between 0 and 50 for x-axis
y_vals = 0.5205 * x_vals - 0.3914;  % Using the equation of the line to get corresponding y values
plot(x_vals, y_vals, 'g', 'LineWidth', 2);  % Plotting the line in green color with a thicker line width
axis([0 50 0 50]);

% Set labels, title and legend for the plot
xlabel('k3');
ylabel('k4');
title('Impact of k3 and k4 on Parasite-Food Dynamics');
legend('Case i', 'Case ii', 'Location', 'southoutside');
