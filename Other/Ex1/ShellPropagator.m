function [rMatrixECI, vMatrixECI, tspan] = ShellPropagator(r0_vect, v0_vect, Espan, t0, amu)
% Description:
% Evaluate the position and velocity vectors with a provided step in
% eccentric anomaly and the corresponding time.

% Proviamo prima con uno span di Eccentricità

n = length(Espan);          % n - size of the span
rMatrixECI = zeros(3, n);   % rMatrixECI - matrix filled with positions
vMatrixECI = zeros(3, n);   % vMatrixECI - matrix filled with velocities
tspan = zeros(1, n);

% Insert Initial Values
rMatrixECI(:, 1) = r0_vect;
vMatrixECI(:, 1) = v0_vect;
tspan(1) = t0;

% Complete the Matrices
for i = 2 : n

    dE = Espan(i) - Espan(i-1);     % E step for propagation

    % from the i-th column we compute the i+1-th column:
    [rMatrixECI(:, i), vMatrixECI(:, i), dt] = CorePropagator(rMatrixECI(:, i-1), vMatrixECI(:, i-1), dE, amu);
    tspan(i) = tspan(i-1) + dt;

end

end
