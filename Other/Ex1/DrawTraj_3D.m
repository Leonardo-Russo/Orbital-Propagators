function DrawTraj_3D(rMatrixECI, color, line)
% Description:
% Create a 3D Plot of the propagated orbit and save it into
% a pdf file.

X = rMatrixECI(1, :);
Y = rMatrixECI(2, :);
Z = rMatrixECI(3, :);

figure('Name', '3D Plot of the Orbit', 'NumberTitle', 'off')

[x,y,z]=sphere;

I = imread('terra.jpg');

surface(6378.1363*x, 6378.1363*y, 6378.1363*z, flipud(I), 'FaceColor', 'texturemap', 'EdgeColor', 'none', 'CDataMapping', 'direct')

hold on
plot3(X,Y,Z,'Color', color, 'Marker', '.','MarkerSize', 5, 'Linestyle', line)
plot3(0,0,0,'g*')
hold off
grid on
axis equal
xlabel('x')
ylabel('y')
zlabel('z')
view([45,45])
title('3D Plot of the Orbit with fixed Eccentric Anomaly Step')


end