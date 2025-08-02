% -------------------------------------------------------------------------
% Author: Nnaji Obinna
% Student ID: 101001461
% Institution: Ontario Tech University
% Project: Rastrigin Function Optimization using GA, DE, and PSO
% Description: This script is part of a comparative study of metaheuristic
% algorithms for minimizing the 2D Rastrigin benchmark function.
% Copyright (c) 2025 Nnaji Obinna & Ontario Tech University.
% All rights reserved.
% -------------------------------------------------------------------------
clc; clear; close all;

%% PSO Parameters
pop_size = 30;
num_gen = 100;
dim = 2;
lb = -5.12;
ub =  5.12;

w = 0.7;          % Inertia weight
c1 = 1.5;         % Cognitive component
c2 = 1.5;         % Social component

%% Initialize Particles
pos = lb + (ub - lb) * rand(pop_size, dim);      % Positions
vel = zeros(pop_size, dim);                      % Velocities
pbest = pos;                                     % Personal bests
pbest_fit = arrayfun(@(i) rastrigin(pos(i,1), pos(i,2)), 1:pop_size)';
[gbest_fit, idx] = min(pbest_fit);
gbest = pbest(idx, :);

best_curve = zeros(num_gen, 1);

%% PSO Main Loop
for gen = 1:num_gen
    for i = 1:pop_size
        % Update velocity
        r1 = rand(1, dim);
        r2 = rand(1, dim);
        vel(i,:) = w * vel(i,:) + ...
                   c1 * r1 .* (pbest(i,:) - pos(i,:)) + ...
                   c2 * r2 .* (gbest - pos(i,:));
        
        % Update position
        pos(i,:) = pos(i,:) + vel(i,:);
        pos(i,:) = max(min(pos(i,:), ub), lb); % Bound check

        % Evaluate fitness
        fit = rastrigin(pos(i,1), pos(i,2));
        
        % Update personal best
        if fit < pbest_fit(i)
            pbest(i,:) = pos(i,:);
            pbest_fit(i) = fit;
        end
        
        % Update global best
        if fit < gbest_fit
            gbest = pos(i,:);
            gbest_fit = fit;
        end
    end

    best_curve(gen) = gbest_fit;
end

%% Results
disp('Best Solution Found by PSO:');
disp(gbest);
disp(['Best Fitness: ', num2str(gbest_fit)]);

%% Plot Convergence
figure;
plot(1:num_gen, best_curve, 'g', 'LineWidth', 2);
xlabel('Generation'); ylabel('Best Fitness');
title('PSO Convergence on Rastrigin');
grid on;

% Export best fitness per generation to CSV
csvwrite('PSO_fitness.csv', best_curve);   

%%  Rastrigin Function 
function z = rastrigin(x, y)
    z = 20 + x.^2 + y.^2 - 10 * (cos(2 * pi * x) + cos(2 * pi * y));
end