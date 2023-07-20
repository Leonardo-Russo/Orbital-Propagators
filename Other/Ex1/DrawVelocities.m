function DrawVelocities(vMatrixECI, tspan)
% Description: the functions plots a graph that shows the evolution of the
% three velocity components over time.

orange = '#ff7403';
teal = '#03ecfc';
green = '#41f247';

vx = vMatrixECI(1, :);
vy = vMatrixECI(2, :);
vz = vMatrixECI(3, :);

figure('Name', 'Plot of the Three Velocity Components', 'NumberTitle','off')

hold on
grid on
plot(tspan, vx, 'Color', orange, 'LineStyle','-', 'Marker','o', 'MarkerSize',3)
plot(tspan, vy, 'Color', green, 'LineStyle','-', 'Marker','o', 'MarkerSize',3)
plot(tspan, vz, 'Color', teal, 'LineStyle','-', 'Marker','o', 'MarkerSize',3)
legend('Vx', 'Vy', 'Vz', 'Location','best')
xlabel('t [s]')
ylabel('Velocity Components [km/s]')
title('Evolution of the Velocity Components')