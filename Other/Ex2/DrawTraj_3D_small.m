function DrawTraj_3D_small(rMatrixECI, rMatrixECI_small)
% Description:
% Create a 3D Plot of the propagated orbit and save it into
% a pdf file.

orange = '#ff7403';
teal = '#03ecfc';

X = rMatrixECI(1, :);
Y = rMatrixECI(2, :);
Z = rMatrixECI(3, :);

X_small = rMatrixECI_small(1, :);
Y_small = rMatrixECI_small(2, :);
Z_small = rMatrixECI_small(3, :);

figure('Name', '3D Plot of the Orbit', 'NumberTitle', 'off')

[x,y,z]=sphere;

I = imread('terra.jpg');

surface(6378.1363*x, 6378.1363*y, 6378.1363*z, flipud(I), 'FaceColor', 'texturemap', 'EdgeColor', 'none', 'CDataMapping', 'direct')

hold on
title('Discrete Points on the 3D Orbit')
plot3(X_small,Y_small,Z_small,'Color', teal, 'Marker', '.','MarkerSize', 1, 'Linestyle', 'none')
plot3(X,Y,Z,'Color', orange, 'Marker', '.','MarkerSize', 10, 'Linestyle', 'none')
plot3(0,0,0,'g*')
hold off
grid on
axis equal
xlabel('x')
ylabel('y')
zlabel('z')
view([45,45])



end