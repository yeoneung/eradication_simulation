% Create a figure for the entire plot (set to wide layout)
figure('Position', [100, 100, 1200, 300]);  % Set width to 1200 for a wider layout

% First comparison (u1 vs u_ref_0_y)
subplot(1, 3, 1);
plot(y_range, u1_y, '-o', 'DisplayName', '$u(0.5, y, 0.1)$', 'LineWidth', 1.5); % Plot u1 with circular markers
hold on;
plot(y_range, u_ref_0_y, '-x', 'DisplayName', '$u_{\mathrm{ref}}$', 'LineWidth', 1.5); % Plot u_ref_0 with X markers
hold off;
xlabel('$y$', 'Interpreter', 'latex', 'FontSize', 20); % Set y-axis label as an equation
ylabel('$u$', 'Interpreter', 'latex', 'FontSize', 20); % Set u-axis label as an equation
xlim([0.1, 1]);
xticks(0.1:0.1:1);  % Set x-axis ticks at 0.1 intervals
legend('Location', 'southeast', 'FontSize', 12, 'Interpreter', 'latex');  % Set legend location and font size
grid on;

% Second comparison (u2 vs u_ref_1_y)
subplot(1, 3, 2);
plot(y_range, u2_y, '-o', 'DisplayName', '$u(0.5, y, 0.3)$', 'LineWidth', 1.5); % Plot u2 with circular markers
hold on;
plot(y_range, u_ref_1_y, '-x', 'DisplayName', '$u_{\mathrm{ref}}$', 'LineWidth', 1.5); % Plot u_ref_1 with X markers
hold off;
xlabel('$y$', 'Interpreter', 'latex', 'FontSize', 20); % Set y-axis label as an equation
ylabel('$u$', 'Interpreter', 'latex', 'FontSize', 20); % Set u-axis label as an equation
xlim([0.1, 1]);
xticks(0.1:0.1:1);  % Set x-axis ticks at 0.1 intervals
legend('Location', 'southeast', 'FontSize', 12, 'Interpreter', 'latex');  % Set legend location and font size
grid on;

% Third comparison (u3 vs u_ref_2_y)
subplot(1, 3, 3);
plot(y_range, u3_y, '-o', 'DisplayName', '$u(0.5, y, 0.5)$', 'LineWidth', 1.5); % Plot u3 with circular markers
hold on;
plot(y_range, u_ref_2_y, '-x', 'DisplayName', '$u_{\mathrm{ref}}$', 'LineWidth', 1.5); % Plot u_ref_2 with X markers
hold off;
xlabel('$y$', 'Interpreter', 'latex', 'FontSize', 20); % Set y-axis label as an equation
ylabel('$u$', 'Interpreter', 'latex', 'FontSize', 20); % Set u-axis label as an equation
xlim([0.1, 1]);
xticks(0.1:0.1:1);  % Set x-axis ticks at 0.1 intervals
legend('Location', 'southeast', 'FontSize', 12, 'Interpreter', 'latex');  % Set legend location and font size
grid on;

% Save the figure as a high-resolution PDF file
exportgraphics(gcf, 'x_fixed.pdf', 'Resolution', 300);
