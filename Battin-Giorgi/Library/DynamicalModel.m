function dX = DynamicalModel(t, X, P)
% Description: This will be the function to integrate to obtain the
% propagation.
% Input: t = tspan(i)   ,   X = [rho; w]    ,   P = Constants
%
% rho = r - r_ref is the relative position of the SC wrt its reference
%   position on the Keplerian orbit;
% w = v - v_ref is the relative velocity of the SC wrt its reference 
%   position on the Keplerian orbit.


% Reading State Values
rho_vect = X(1:3);
w_vect = X(4:6);
COE0 = P(1:6);
mu = P(7);
f = P(8:10);
ref_steps = P(11);

a = COE0(1);
e = COE0(2);


% Initialize State Derivative
dX = zeros(6,1);


% Introduce Local Variables
T = sqrt(a^3/mu);
n = sqrt(mu/(a^3));         % mean angular motion
M = n*t;
E = M2E(e,M);
delta_E = E/ref_steps;      % angular step     
b = a*sqrt(1-e^2);
[r0_ref, v0_ref] = coe2rvECI(COE0, mu);

COE_i = COE0;
r_ref_i = reshape(r0_ref, 3, 1);
v_ref_i = reshape(v0_ref, 3, 1);

    for j = 1 : ref_steps-1
    
        r_ref = norm(r_ref_i);
        h_ref = norm(cross(r_ref_i, v_ref_i));
        dt_i =  b * r_ref / h_ref * delta_E;
        COE_i = NuPropagator(COE_i, dt_i, mu);
        [r_ref_i, v_ref_i] = coe2rvECI(COE_i, mu);

    end
  

% Compute Perturbing Force in ECI Frame 
r_p = r_ref_i + rho_vect;
v_p = v_ref_i + w_vect;

COE_i = rvECI2coe(r_p, v_p);
i = COE_i(3);
Omega = COE_i(4);
omega = COE_i(5);
nu = COE_i(6);

f_cart = R3(-Omega)*R1(-i)*R3(-omega)*R3(-nu)*f;


% Battin-Giorgi Differential Equations
r0 = norm(r_ref_i);
rho = norm(rho_vect);

q = 2* dot(r_ref_i/r0^2, rho_vect) + (rho/r0)^2;   


% Assign Values to State Derivatives
dX(1:3) = w_vect;
dX(4:6) = mu/r0^3 * ( ( q*(2+q+sqrt(1+q)) )/ ( (1+sqrt(1+q))*(1+q)^(3/2) ) ) * r_ref_i - ...
    mu/(r0^3*(1+q)^(3/2))*rho_vect + f_cart;


end