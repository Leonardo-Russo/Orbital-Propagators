function DrawTraj_3D_Helper(rMatrixECI, title)
% Description:
% Create a 3D Plot of the propagated orbit and save it into
% a pdf file.

% This helper shows the points along the trajectory in which there is a
% significant change in at least one of the XYZ coordinates.
% This was helpful since there was an error with the eccentric anomaly
% outside the [0, 2pi] interval which caused Matlab to plot the correct
% coordinates in the wrong order...

X = rMatrixECI(1, :);
Y = rMatrixECI(2, :);
Z = rMatrixECI(3, :);

special_points = [];

tol = 1;

for i = 2 : length(X)-1
    if abs((X(i)-X(i-1))/X(i)) > tol || abs((Y(i)-Y(i-1))/Y(i)) > tol || abs((Z(i)-Z(i-1))/Z(i)) > tol
        special_points = [special_points; X(i), Y(i), Z(i)];

    end
end

fig_title = strcat("Plot 3D dell'orbita ", title);

figure('Name', fig_title, 'NumberTitle', 'off')

[x,y,z]=sphere;

I = imread('terra.jpg');

surface(6378.1363*x, 6378.1363*y, 6378.1363*z, flipud(I), 'FaceColor', 'texturemap', 'EdgeColor', 'none', 'CDataMapping', 'direct')

hold on
plot3(X,Y,Z,'-b')
plot3(0,0,0,'g*')
plot3(special_points(:, 1), special_points(:, 2), special_points(:, 3), 'r*')
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