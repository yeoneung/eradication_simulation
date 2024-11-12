% Create a figure for the entire plot (size adjustment)
figure('Position', [100, 100, 1200, 400]);  % Set width to 1200 for a wider layout

% Calculate the minimum and maximum values in the u array (unify colorbar range)
u_min = 0;
u_max = 5;

% Set label font size
label_font_size = 20;

% Mesh plot for u1
subplot(1, 3, 1);
mesh(x_mesh, y_mesh, u1', 'LineWidth', 1.5);  % Adjust line width with LineWidth
caxis([u_min, u_max]);  % Unify colorbar range
xlabel('$x$', 'Interpreter', 'latex', 'FontSize', label_font_size);
ylabel('$y$', 'Interpreter', 'latex', 'FontSize', label_font_size);
zlabel('$u$', 'Interpreter', 'latex', 'FontSize', label_font_size, 'Rotation', -90); % Rotate zlabel by 90 degrees clockwise
zlim([0, 5]);
xticks(0:0.2:1);  % Set x-axis ticks from 0 to 1 with 0.2 intervals
yticks(0.1:0.1:1);  % Set y-axis ticks from 0.1 to 1 with 0.1 intervals
grid on;

% Mesh plot for u2
subplot(1, 3, 2);
mesh(x_mesh, y_mesh, u2', 'LineWidth', 1.5);
caxis([u_min, u_max]);  % Unify colorbar range
xlabel('$x$', 'Interpreter', 'latex', 'FontSize', label_font_size);
ylabel('$y$', 'Interpreter', 'latex', 'FontSize', label_font_size);
zlabel('$u$', 'Interpreter', 'latex', 'FontSize', label_font_size, 'Rotation', -90); % Rotate zlabel by 90 degrees clockwise
xticks(0:0.2:1);  % Set x-axis ticks from 0 to 1 with 0.2 intervals
yticks(0.1:0.1:1);  % Set y-axis ticks from 0.1 to 1 with 0.1 intervals
grid on;

% Mesh plot for u3
subplot(1, 3, 3);
mesh(x_mesh, y_mesh, u3', 'LineWidth', 1.5);
caxis([u_min, u_max]);  % Unify colorbar range
xlabel('$x$', 'Interpreter', 'latex', 'FontSize', label_font_size);
ylabel('$y$', 'Interpreter', 'latex', 'FontSize', label_font_size);
zlabel('$u$', 'Interpreter', 'latex', 'FontSize', label_font_size, 'Rotation', -90); % Rotate zlabel by 90 degrees clockwise
xticks(0:0.2:1);  % Set x-axis ticks from 0 to 1 with 0.2 intervals
yticks(0.1:0.1:1);  % Set y-axis ticks from 0.1 to 1 with 0.1 intervals
grid on;

% Add a common colorbar (positioned on the far right of the figure)
h = colorbar;
h.Position = [0.93, 0.1, 0.02, 0.8];  % Position the colorbar to the far right
ylabel(h, '$u$', 'Interpreter', 'latex', 'FontSize', label_font_size, 'Rotation', -90);  % Rotate colorbar label by 90 degrees clockwise

% Save the figure as a high-resolution PDF file (e.g., 300 dpi)
exportgraphics(gcf, 'surface_plot.pdf', 'Resolution', 300); 
