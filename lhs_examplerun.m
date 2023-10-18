% number of trials
n = 10;

% Upper and lower bounds for parameters

k3L = 0;
k3U = 50;

k4L = 0;
k4U = 50;

% Setup n even intervals between the bounds
k3intervals = linspace(k3L, k3U,n+1);
k4intervals = linspace(k4L,k4U,n+1);
lhsdesign
% randomly sample in each interval 
for i = 1:n
    u = rand;
    k3samples(i) = (k3intervals(i+1)-k3intervals(i))*u+k3intervals(i);
end 

for i = 1:n
    u = rand;
    k4samples(i) = (k4intervals(i+1)-k4intervals(i))*u+k4intervals(i);
end 

% randomise the indexing using randperm(n)
random_index_k3 = randperm(n);
random_index_k4 = randperm(n);

% Create samples
samples = [k3samples(random_index_k3)', k4samples(random_index_k4)']

% Plot samples 
figure
hold on
plot(samples(:,1), samples(:,2),'o')
xlim([k3L,k3U])
ylim([k4L,k4U])
grid on
xlabel('k3')
ylabel('k4')





