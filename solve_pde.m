% Parameter settings
% dx dy GREATER THAN 0.1
dx = 0.01;
dy = 0.01;
dt = 0.005;
mu0 = 0.1;

x_range = 0:dx:1;
y_range = mu0:dy:1;
t_range = 0:dt:0.5;

Nx = length(x_range);
Ny = length(y_range);
Nt = length(t_range);

u = zeros(Nx, Ny, Nt);

% Define beta and gamma functions
% beta = @(t, tau) (1 / (t + tau + 0.1)/2 * sin((t/2 + tau)) + 0.1); 
% gamma = @(t, tau) (1 / (t + tau + 0.5)/2 * cos((t/2 + tau)) + 0.5);

beta = @(t, tau) (exp(-t - tau) * sin((t/2 + tau/2)) + 0.5); 
gamma = @(t, tau) (exp(-t - tau) * cos((t/2 + tau/2)) + 0.7);

% Initialize initial conditions
for i = 1:Nx
    for j = 1:Ny
        x = x_range(i);
        y = y_range(j);
        u(i, j, 1) = calculate_optimal_time(x, y, 0);
    end
end

% Set boundary conditions
for s = 1:Nt
    tau = t_range(s);

    for j = 1:Ny
        u(1, j, s) = calculate_optimal_time(x_range(1), y_range(j), tau);
        u(Nx, j, s) = calculate_optimal_time(x_range(end), y_range(j), tau);
    end

    for i = 1:Nx
        u(i, 1, s) = calculate_optimal_time(x_range(i), y_range(1), tau);
        u(i, Ny, s) = calculate_optimal_time(x_range(i), y_range(end), tau);
    end
end

% Time evolution
for n = 1:Nt-1
    t = t_range(n);

    for i = 2:Nx-1
        for j = 2:Ny-1
            du_dx = (u(i+1, j, n) - u(i-1, j, n)) / (2*dx);
            du_dy = (u(i, j+1, n) - u(i, j-1, n)) / (2*dy);

            % du_dx_2 = (u(i+1, j, n) - u(i-1, j, n)) / (2*dx);

            du_dx_positive = max(du_dx, 0);
            % du_dx_positive = x / (1 + 5 * exp(-x));

            u(i, j, n+1) = (u(i, j, n) + u(i-1, j, n)) / 4 + (u(i, j+1, n) + u(i, j-1, n)) / 4 + dt * ( ...
                beta(t, 0) * x_range(i) * y_range(j) * du_dx + ...
                x_range(i) * du_dx_positive + ...
                (gamma(t, 0) - beta(t, 0) * x_range(i)) * y_range(j) * du_dy -1 );
        end
    end
end

% Output results
