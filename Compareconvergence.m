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

% Load data
GA_curve  = csvread('GA_fitness.csv');
DE_curve  = csvread('DE_fitness.csv');
PSO_curve = csvread('PSO_fitness.csv');

% Plot
figure;
plot(GA_curve, 'b', 'LineWidth', 2); hold on;
plot(DE_curve, 'r', 'LineWidth', 2);
plot(PSO_curve, 'g', 'LineWidth', 2);
legend('GA', 'DE', 'PSO');
xlabel('Generation'); ylabel('Best Fitness');
title('Convergence Comparison: GA vs DE vs PSO');
grid on;