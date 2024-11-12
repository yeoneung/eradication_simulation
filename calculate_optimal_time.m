% calculate_optimal_time.m
function [optimal_time, optimal_control, I] = calculate_optimal_time(x, y, s)
    % x, y는 초기 조건 S(1)과 I(1)이고, s는 tau 값입니다.
    
    % 파라미터 설정
    dts = 0.01;
    N = 1000;
    segments = 2;  % multiple shooting을 위해 시간을 여러 구간으로 나눔
    segment_length = N / segments;
    mu = 0.1/2;

    % 전역 변수로 초기값 설정
    global S0 I0;
    S0 = x; % S(1) 값을 x로 설정
    I0 = y; % I(1) 값을 y로 설정

    % 전염병 매개변수
    %beta = @(t, tau) (1 / (t + tau + 0.1)/2 * sin((t/2 + tau)) + 0.1); 
    %gamma = @(t, tau) (1 / (t + tau + 0.5)/2 * cos((t/2 + tau)) + 0.5);

beta = @(t, tau) (exp(-t-tau) * sin((t/2 + tau/2)) + 0.5); 
gamma = @(t, tau) (exp(-t-tau) * cos((t/2 + tau/2)) + 0.7);

    % 초기 제어 변수 및 상태 설정
    initial_control = ones(N, 1);  % 전체 제어 변수 초기값
    initial_conditions = [S0; I0]; % 초기 상태
    lb = zeros(N, 1);               % 제어 변수 하한
    ub = ones(N, 1);                % 제어 변수 상한
    
    % Objective function 정의
    objective_function = @(U) multiple_shooting_objective(U, initial_conditions, segments, segment_length, dts, mu, s, beta, gamma);
    
    % fmincon 옵션 설정
    options = optimoptions('fmincon', 'Display', 'off', 'Algorithm', 'sqp');

    % 최적화 수행
    optimal_control = fmincon(objective_function, initial_control, [], [], [], [], lb, ub, [], options);

    % 최적 시간 계산
    optimal_time = objective_function(optimal_control) * dts;

    % 최적 제어에 따른 상태 변수 (S, I 계산)
    [S, I] = dynamics(optimal_control, N, dts, s, beta, gamma);
    
    % 최종 감염자 수 (I) 반환
    I = I;
end

function T = multiple_shooting_objective(U, initial_conditions, segments, segment_length, dt, mu, tau, beta, gamma)
    global S0 I0;
    S0 = initial_conditions(1);
    I0 = initial_conditions(2);
    
    % 각 구간에 대해 초기 조건을 설정하고 연속성 제약을 적용
    T = 0;
    for seg = 1:segments
        start_idx = (seg - 1) * segment_length + 1;
        end_idx = seg * segment_length;

        % 현재 구간 제어 변수
        U_segment = U(start_idx:end_idx);

        % 동역학 계산 (구간 내에서)
        [S, I] = dynamics(U_segment, segment_length, dt, tau, beta, gamma);

        % 다음 구간의 초기 조건이 이전 구간의 마지막 상태와 같도록 제약
        if seg < segments
            S0 = S(end);  % 다음 구간의 초기 S
            I0 = I(end);  % 다음 구간의 초기 I
        end

        % 감염자의 수가 임계값 이하일 때의 시간을 확인
        for k = 1:segment_length
            if I(k) < mu
                T = T + (seg - 1) * segment_length + k;
                return;
            end
        end
    end
    
    % 만약 감염자 수가 모든 구간에서 임계값 이하로 떨어지지 않으면 전체 구간 길이 반환
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
