function DrawTrajs_3D(rMatrixECI_M1, rMatrixECI_M2, rMatrixECI_M3)
% Description:
% Create a 3D Plot of the 3 propagated orbits and save it into
% a pdf file.

X1 = rMatrixECI_M1(1, :);
Y1 = rMatrixECI_M1(2, :);
Z1 = rMatrixECI_M1(3, :);

X2 = rMatrixECI_M2(1, :);
Y2 = rMatrixECI_M2(2, :);
Z2 = rMatrixECI_M2(3, :);

X3 = rMatrixECI_M3(1, :);
Y3 = rMatrixECI_M3(2, :);
Z3 = rMatrixECI_M3(3, :);

fig_title = 'Plot 3D delle 3 Orbite Molniya';

figure('Name', fig_title, 'NumberTitle', 'off')

[x,y,z]=sphere;

I = imread('terra.jpg');

surface(6378.1363*x, 6378.1363*y, 6378.1363*z, flipud(I), 'FaceColor', 'texturemap', 'EdgeColor', 'none', 'CDataMapping', 'direct')

hold on
plot3(X1,Y1,Z1,'-b')
plot3(X2,Y2,Z2,'-b')
plot3(X3,Y3,Z3,'-b')
plot3(0,0,0,'g*')
hold off
grid on
axis equal
xlabel('x')
ylabel('y')
zlabel('z')
view([45,45])

% iResolution = 600;
% ImgNameStr = title;
% print('-dpdf',sprintf('-r%d',iResolution),strcat(ImgNameStr,'.pdf'));

end