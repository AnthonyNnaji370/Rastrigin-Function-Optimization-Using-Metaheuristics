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


% Function Definition
function z = rastrigin(x, y)
    z = 20 + x.^2 + y.^2 - 10 * (cos(2 * pi * x) + cos(2 * pi * y));
end
clc; clear; close all;

%% GA Parameters
pop_size = 30;          % Population size
num_gen = 100;          % Number of generations
pc = 0.8;               % Crossover probability
pm = 0.1;               % Mutation probability
lb = -5.12;             % Lower bound
ub =  5.12;             % Upper bound

%% Initialize Population
% Each individual is [x y]
pop = lb + (ub - lb) * rand(pop_size, 2);
fitness = arrayfun(@(i) rastrigin(pop(i,1), pop(i,2)), 1:pop_size)';

[best_fitness, idx] = min(fitness);
best_solution = pop(idx,:);

%% GA Main Loop
best_curve = zeros(num_gen,1);

for gen = 1:num_gen
    new_pop = pop; % Offspring container
    
    % Selection and Crossover
    for i = 1:2:pop_size
        % Tournament selection
        p1 = pop(tournament_select(fitness), :);
        p2 = pop(tournament_select(fitness), :);
        
        % Crossover
        if rand < pc
            [child1, child2] = single_point_crossover(p1, p2);
        else
            child1 = p1; child2 = p2;
        end
        
        new_pop(i,:) = child1;
        if i+1 <= pop_size
            new_pop(i+1,:) = child2;
        end
    end
    
    % Mutation
    for i = 1:pop_size
        if rand < pm
            new_pop(i,:) = mutation(new_pop(i,:), lb, ub);
        end
    end
    
    % Evaluate fitness
    pop = new_pop;
    fitness = arrayfun(@(i) rastrigin(pop(i,1), pop(i,2)), 1:pop_size)';
    
    % Update best solution
    [current_best, idx] = min(fitness);
    if current_best < best_fitness
        best_fitness = current_best;
        best_solution = pop(idx,:);
    end
    
    best_curve(gen) = best_fitness;
end

%% Results
disp('Best Solution Found by GA:');
disp(best_solution);
disp(['Best Fitness: ', num2str(best_fitness)]);

%% Plot Convergence
figure;
plot(1:num_gen, best_curve, 'LineWidth', 2);
xlabel('Generation'); ylabel('Best Fitness');
title('GA Convergence on Rastrigin');
grid on;

% Export best fitness per generation to CSV
csvwrite('GA_fitness.csv', best_curve);   
%% Helper Functions
function idx = tournament_select(fitness)
    k = 3; % Tournament size
    competitors = randi(length(fitness), [1, k]);
    [~, best_idx] = min(fitness(competitors));
    idx = competitors(best_idx);
end

function [c1, c2] = single_point_crossover(p1, p2)
    alpha = rand;
    c1 = alpha * p1 + (1 - alpha) * p2;
    c2 = alpha * p2 + (1 - alpha) * p1;
end

function mutant = mutation(ind, lb, ub)
    mutation_strength = 0.1 * (ub - lb);
    mutant = ind + mutation_strength * randn(size(ind));
    mutant = max(min(mutant, ub), lb); % Clip to bounds
end