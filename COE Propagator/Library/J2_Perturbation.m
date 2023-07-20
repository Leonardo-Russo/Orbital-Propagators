function [aPr, aPt, aPh] = J2_Perturbation(COE)
% Description: this function return the components of the J2 perturbation
% in the LVLH reference frame. -> aP = [aPr, aPt, aPh].
% Note that it is required to provide the COE state as input parameter.

% Define Known Parameters
global mu rE
J2 = 1.082e-3;      % Oblateness Coefficient

% Retrieve Data from Input
a = COE(1);
e = COE(2);
incl = COE(3);
omega = COE(4);
Omega = COE(5);
nu = COE(6);

% Compute Local Variables
p = a*(1-e^2);
r = p / (1+e*cos(nu));
theta = omega + nu;

% Find Perturbation Effects
aPr = 3*mu/r^4 * rE^2 * J2 * (3*sin(theta)^2*sin(incl)^2 - 1)/2;
aPt = -3*mu/r^4 * rE^2 * J2 * sin(incl)^2*sin(theta)*cos(theta);
aPh = -3*mu/r^4 * rE^2 * J2 * sin(incl)*cos(incl)*sin(theta);


end