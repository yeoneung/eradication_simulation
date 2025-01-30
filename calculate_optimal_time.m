function [optimal_time, optimal_control, I] = calculate_optimal_time(x, y, s)
    % x, y are the initial conditions S(1) and I(1), and s is the tau value.
    
    % Parameter settings
    dts = 0.01;
    N = 1000;
    segments = 2;  % Divide time into multiple segments for multiple shooting
    segment_length = N / segments;
    mu = 0.1/2;

    % Set initial values as global variables
    global S0 I0;
    S0 = x; % Set S(1) to x
    I0 = y; % Set I(1) to y

    % Epidemic parameters
    beta = @(t, tau) (exp(-t-tau) * sin((t/2 + tau/2)) + 0.5); 
    gamma = @(t, tau) (exp(-t-tau) * cos((t/2 + tau/2)) + 0.7);

    % Initial control variable and state settings
    initial_control = ones(N, 1);  % Initial values for the control variable
    initial_conditions = [S0; I0]; % Initial state
    lb = zeros(N, 1);               % Lower bound for control variable
    ub = ones(N, 1);                % Upper bound for control variable
    
    % Define the objective function
    objective_function = @(U) multiple_shooting_objective(U, initial_conditions, segments, segment_length, dts, mu, s, beta, gamma);
    
    % Set fmincon options
    options = optimoptions('fmincon', 'Display', 'off', 'Algorithm', 'sqp');

    % Perform optimization
    optimal_control = fmincon(objective_function, initial_control, [], [], [], [], lb, ub, [], options);

    % Compute optimal time
    optimal_time = objective_function(optimal_control) * dts;

    % Compute state variables (S, I) based on optimal control
    [S, I] = dynamics(optimal_control, N, dts, s, beta, gamma);
    
    % Return the final number of infected individuals (I)
    I = I;
end

function T = multiple_shooting_objective(U, initial_conditions, segments, segment_length, dt, mu, tau, beta, gamma)
    global S0 I0;
    S0 = initial_conditions(1);
    I0 = initial_conditions(2);
    
    % Set initial conditions for each segment and apply continuity constraints
    T = 0;
    for seg = 1:segments
        start_idx = (seg - 1) * segment_length + 1;
        end_idx = seg * segment_length;

        % Control variable for the current segment
        U_segment = U(start_idx:end_idx);

        % Compute dynamics within the segment
        [S, I] = dynamics(U_segment, segment_length, dt, tau, beta, gamma);

        % Ensure continuity by setting the initial condition of the next segment
        if seg < segments
            S0 = S(end);  % Initial S for the next segment
            I0 = I(end);  % Initial I for the next segment
        end

        % Check the time when the number of infected individuals falls below the threshold
        for k = 1:segment_length
            if I(k) < mu
                T = T + (seg - 1) * segment_length + k;
                return;
            end
        end
    end
    
    % If the number of infected individuals never falls below the threshold, return the total segment length
    T = segments * segment_length;
end

function [S, I] = dynamics(U, N, dt, tau, beta, gamma)
    global S0 I0;
    S = zeros(N + 1, 1);
    I = zeros(N + 1, 1);
    S(1) = S0;
    I(1) = I0;

    for k = 1:N
        S(k + 1) = S(k) - dt * (beta(dt * (k - 1), tau) * S(k) * I(k) + U(k) * S(k));
        I(k + 1) = I(k) + dt * (beta(dt * (k - 1), tau) * S(k) * I(k) - gamma(dt * (k - 1), tau) * I(k));
    end
end
