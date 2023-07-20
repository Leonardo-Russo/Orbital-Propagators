function [A] = A_Matrix(X)
% Description: This function contains the dynamical model used for the
% Cowell's Integration.

N = lenght(X);

% Initialize the Matrix and Read values from State
A = zeros(N, N);

x = X(1);
y = X(2);
z = X(3);
u = X(4);
v = X(5);
w = X(6);
% mu = X(7);

r = sqrt(x^2 + y^2 + z^2);

% Building of A Matrix
A(1, 4) = 1;
A(2, 5) = 1;
A(3, 6) = 1;
A(4, 1) = -mu/r^3 + 3*mu*x^2/r^5;
A(4, 2) = 3*mu*x*y/r^5;
A(4, 3) = 3*mu*x*z/r^5;
A(5, 1) = 3*mu*x*y/r^5;
A(5, 2) = -mu/r^3 + 3*mu*y^2/r^5;
A(5, 3) = 3*mu*y*z/r^5;
A(6, 1) = 3*mu*z*x/r^5;
A(6, 2) = 3*mu*z*y/r^5;
A(6, 3) = -mu/r^3 + 3*mu*z^2/r^5;

% the rest of A is full of zeroes

end