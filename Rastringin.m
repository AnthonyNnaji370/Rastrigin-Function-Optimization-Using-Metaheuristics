function z = rastrigin(x, y)
    % Rastrigin function (2D)
    z = 20 + x.^2 + y.^2 - 10 * (cos(2 * pi * x) + cos(2 * pi * y));
end
% Rastrigin Function Surface Plot
clc; clear;

% Define the domain
x = linspace(-5.12, 5.12, 100);
y = linspace(-5.12, 5.12, 100);
[X, Y] = meshgrid(x, y);

% Evaluate the function
Z = rastrigin(X, Y);

% Plot
figure;
surf(X, Y, Z, 'EdgeColor', 'none');
colormap jet;
xlabel('x'); ylabel('y'); zlabel('f(x, y)');
title('2D Rastrigin Function');
colorbar;