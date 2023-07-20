function dx = DynamicalModel(t, X)
% Description: This will be the function to integrate to obtain the
% propagation.
% Input: t = tspan(i), X = X(i) = [x, y, z, u, v, z, mu]

N = length(X);

x = X(1);
y = X(2);
z = X(3);
u = X(4);
v = X(5);
w = X(6);
mu = X(7);

r = sqrt(x^2 + y^2 + z^2);

dx = zeros(N, 1);

dx(1) = u;
dx(2) = v;
dx(3) = w;
dx(4) = -mu/r^3 * x;
dx(5) = -mu/r^3 * y;
dx(6) = -mu/r^3 * z;


end