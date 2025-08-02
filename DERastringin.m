
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

%% DE Parameters
pop_size = 30;
num_gen = 100;
F = 0.8;         % Differential weight
CR = 0.9;        % Crossover rate
dim = 2;         % Problem dimension (x, y)
lb = -5.12;
ub =  5.12;

%% Initialize Population
pop = lb + (ub - lb) * rand(pop_size, dim);
fitness = arrayfun(@(i) rastrigin(pop(i,1), pop(i,2)), 1:pop_size)';

[best_fitness, idx] = min(fitness);
best_solution = pop(idx, :);
best_curve = zeros(num_gen, 1);

%% DE Main Loop
for gen = 1:num_gen
    for i = 1:pop_size
        % Mutation: DE/rand/1
        idxs = randperm(pop_size, 3);
        while any(idxs == i)
            idxs = randperm(pop_size, 3);
        end
        a = pop(idxs(1), :);
        b = pop(idxs(2), :);
        c = pop(idxs(3), :);
        mutant = a + F * (b - c);
        mutant = max(min(mutant, ub), lb); % Bound check

        % Crossover
        trial = pop(i, :);
        j_rand = randi(dim);
        for j = 1:dim
            if rand < CR || j == j_rand
                trial(j) = mutant(j);
            end
        end

        % Selection
        trial_fit = rastrigin(trial(1), trial(2));
        if trial_fit < fitness(i)
            pop(i, :) = trial;
            fitness(i) = trial_fit;
        end
    end

    % Track best solution
    [current_best, idx] = min(fitness);
    if current_best < best_fitness
        best_fitness = current_best;
        best_solution = pop(idx, :);
    end

    best_curve(gen) = best_fitness;
end

%% Results
disp('Best Solution Found by DE:');
disp(best_solution);
disp(['Best Fitness: ', num2str(best_fitness)]);

%% Plot Convergence
figure;
plot(1:num_gen, best_curve, 'r', 'LineWidth', 2);
xlabel('Generation'); ylabel('Best Fitness');
title('DE Convergence on Rastrigin');
grid on;

% Export best fitness per generation to CSV
csvwrite('DE_fitness.csv', best_curve);  
%%  Rastrigin Function
function z = rastrigin(x, y)
    z = 20 + x.^2 + y.^2 - 10 * (cos(2 * pi * x) + cos(2 * pi * y));
end