%% Battin Giorgi Propagator - Leonardo Russo 2015563

clear all
close all
clc

% addpath("Library\")

savechoice = 0;

%% Introduction to Known Parameters

global mu rE

mu = 398600.4415;           % km^3/s^2
rE = 6378.1363;             % km
D_sid = 86164;              % s
D_sol = 86400;              % s


% Initial Conditions of Common Orbits
r0_GPS = [13462.726354, -20645.023752, 10108.071628]';
v0_GPS = [2.638622 ,0.329454, -2.805018]';

r0_Mol = [2869.944136, -1656.963019, -6617.757380]';
v0_Mol = [4.814217, 8.338469, 0.0]';

r0_Geo = [-29260.792529, 23865.119693, 23865.119693]';
v0_Geo = [-2.334835, -1.212853, -1.212853]';

% User Defined Initial Conditions
r0_1 = [-9260.792529, 23865.119693, 23865.119693]';
v0_1 = [-2.334835, -1.212853, -1.212853]';

% User Defined Initial Conditions via COE -> [a e i Omega omega nu0]
a = rE + 10000;         % km
e = 0.5;
incl = deg2rad(40);     % rad
Omega = deg2rad(26);    % rad
omega = deg2rad(1);     % rad
nu0 = deg2rad(0);       % rad

COE0 = [a, e, incl, Omega, omega, nu0]';

if e > 1
    error('Eccentricity in greater than one!')
end


%% Propagation of the Non-Perturbed Keplerian Orbit

% Define Initial Conditions
X0 = COE0;

% Define the Time Domain
n = 1;                      % orbital periods to be propagated
t0 = 0;
a0 = X0(1);                 % initial semi-major axis
T = 2*pi*sqrt(a0^3/mu);     % orbital period
tf = t0 + n*T;

ref_steps = 1000;
M = ref_steps*n;
rMatrix_ref = zeros(M, 3);
vMatrix_ref = zeros(M, 3);
tspan = zeros(M, 1);

[r0_ref, v0_ref] = coe2rvECI(COE0, mu);
rMatrix_ref(1, :) = r0_ref;
vMatrix_ref(1, :) = v0_ref;

delta_E = 2*pi/ref_steps;
b = a*sqrt(1-e^2);

COE_i = COE0;       % Initial Conditions

for k = 1 : n

    for j = 1 : ref_steps-1

        i = j + (k-1)*ref_steps;        % variables access index

        r_ref = norm(rMatrix_ref(i, :));
        h_ref = norm(cross(rMatrix_ref(i, :), vMatrix_ref(i, :)));
        dt_i =  b * r_ref / h_ref * delta_E;
        COE_i = NuPropagator(COE_i, dt_i, mu);
        [rMatrix_ref(i+1, :), vMatrix_ref(i+1, :)] = coe2rvECI(COE_i, mu);
        tspan(i+1) = tspan(i) + dt_i;

    end
    
    if k < n    % final computation at j = ref_steps
        
        i = j+1 + (k-1)*ref_steps;        % variables access index

        r_ref = norm(rMatrix_ref(i, :));
        h_ref = norm(cross(rMatrix_ref(i, :), vMatrix_ref(i, :)));
        dt_i =  b * r_ref / h_ref * delta_E;
        COE_i = NuPropagator(COE_i, dt_i, mu);
        [rMatrix_ref(i+1, :), vMatrix_ref(i+1, :)] = coe2rvECI(COE_i, mu);
        tspan(i+1) = tspan(i) + dt_i;

    end

end

figure('Name', 'Reference Trajectory Representation in 3D')
DrawTraj3D(rMatrix_ref)

if savechoice
    saveas(gcf,'3D Perturbed Trajectory.jpg')
end


%% Propagation of the Perturbed Orbit

f = [0 0 1e-8]';        % Constant Perturbing Acceleration

X0 = zeros(6, 1);       % Initial Conditions for the Propagation

% Defining the options for the Integration
Tol0 = 1e-9;
Tol1 = 1e-11;
MaxStep = 60;
options = odeset('RelTol', Tol0, 'AbsTol',Tol1, 'MaxStep', MaxStep);

P = [COE0; mu; f; ref_steps];       % constant parameters

% Perform the Propagation
[tspan_p, Xp] = ode113(@(t, X) DynamicalModel(t, X, P), tspan, X0, options);

rhoMatrix = Xp(:, 1:3);
wMatrix = Xp(:, 4:6);

rMatrix_p = rMatrix_ref + rhoMatrix;
vMatrix_p = rMatrix_ref + wMatrix;


figure('Name', 'Perturbed Trajectory Representation in 3D')
DrawTraj3D(rMatrix_ref)
DrawTraj3D(rMatrix_p)

if savechoice
    saveas(gcf,'3D Perturbed Trajectory.jpg')
end


