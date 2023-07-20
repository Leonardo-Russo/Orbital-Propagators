%% Orbital Elements Propagator - Leonardo Russo 2015563

clear all
close all
clc

addpath("Library\")

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

COE0 = [a, e, incl, Omega, omega, nu0];

if e > 1
    error('Eccentricity in greater than one!')
end


%% Propagation Shell

% Define Initial Conditions
r0 = r0_Mol;
v0 = v0_Mol;
X0 = rvECI2coe(r0, v0, mu)';

X0 = COE0;

% Define the Time Domain
n = 1;                      % orbital periods to be propagated
t0 = 0;
a0 = X0(1);                 % initial semi-major axis
T = 2*pi*sqrt(a0^3/mu);     % orbital period
tf = t0 + n*T;

% Defining the options for the Integration
Tol0 = 1e-11;
Tol1 = 1e-13;
MaxStep = 60;
options = odeset('RelTol', Tol0, 'AbsTol',Tol1, 'MaxStep', MaxStep);

% Perform the Propagation
[tspan, X] = ode113('DynamicalModel', [t0, tf], X0, options);

% Store the Results
X = X(:, 1:6);
a = X(:, 1);
e = X(:, 2);
incl = X(:, 3);
omega= X(:, 4);
Omega = X(:, 5);
nu = X(:, 6);

M = length(tspan);
rMatrixECI = zeros(M, 3);

for j = 1 : M
    [r_vect, v_vect] = coe2rvECI(X(j, :), mu);
    rMatrixECI(j, :) = r_vect';
end


%% Plot of the Results

figure('Name', 'Trajectory Representation in 3D')
DrawTraj3D(rMatrixECI)

if savechoice
    saveas(gcf,'3D Trajectory.jpg')
end


%% Show the Effect of J2

n = 10;
tf1 = t0 + n*T;

% Perform the Propagation
[tspan, X] = ode113('DynamicalModel', [t0, tf1], X0, options);

% Store the Results
X = X(:, 1:6);
a = X(:, 1);
e = X(:, 2);
incl = X(:, 3);
omega= X(:, 4);
Omega = X(:, 5);
nu = X(:, 6);

M = length(tspan);
rMatrixECI1 = zeros(M, 3);

for j = 1 : M
    if tspan(j) >= t0 + (n-1)*T
        [r_vect, v_vect] = coe2rvECI(X(j, :), mu);
        rMatrixECI1(j, :) = r_vect';
    end
end

figure('Name', 'Evolution of the Initial Orbit')
DrawTraj3D(rMatrixECI)
hold on
DrawTraj3D(rMatrixECI1)

if savechoice
    saveas(gcf,'Comparison.jpg')
end




