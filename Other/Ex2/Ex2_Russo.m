%% Ex2 - Leonardo Russo 2015563

clear all
close all
clc

%% Known Quantities and Initial Conditions

amu = 398600.4415;          % km^3/s^2
rE_equator = 6378.1363;     % km
D_sid = 86164;              % s
D_sol = 86400;              % s

% Initial Conditions contain position and velocity vectors

r0_GPS = [13462.726354, -20645.023752, 10108.071628]';
v0_GPS = [2.638622 ,0.329454, -2.805018]';
IC_GPS = [r0_GPS; v0_GPS];

r0_Mol = [2869.944136, -1656.963019, -6617.757380]';
v0_Mol = [4.814217, 8.338469, 0.0]';
IC_Mol = [r0_Mol; v0_Mol];

r0_Geo = [-29260.792529, 23865.119693, 23865.119693]';
v0_Geo = [-2.334835, -1.212853, -1.212853]';
IC_Geo = [r0_Geo; v0_Geo];

% New Initial Conditions
r0_1 = [-9260.792529, 23865.119693, 23865.119693]';
v0_1 = [-2.334835, -1.212853, -1.212853]';
IC_1 = [r0_Geo; v0_Geo];

% New Initial Conditions via COE = [a e i Omega omega nu0]
a = rE_equator + 10000;   % km
e = 0.3;
incl = deg2rad(40);     % rad
Omega = deg2rad(26);    % rad
omega = deg2rad(1);    % rad
nu0 = deg2rad(0);       % rad

COE1 = [a, e, incl, Omega, omega, nu0];

[r0_2, v0_2] = coe2rvECI(COE1, amu);

if e > 1
    error('Eccentricity in greater than one!')
end

Estep = 0.1;
Espan = 0 : Estep : 2*pi;
t0 = 0;

Esmallstep = 0.001;
Esmallspan = 0 : Esmallstep : 2*pi;

orange = '#ff7403';
teal = '#03ecfc';

%% Propagator Core

% Import Initial Conditions of Choice
r0_vect = r0_GPS;
v0_vect = v0_GPS;

% Create 3D Map
[rMatrixECI, vMatrixECI, tspan] = ShellPropagator(r0_vect, v0_vect, Espan, t0, amu);
DrawTraj_3D(rMatrixECI, orange, 'none');
% saveas(gcf,'3D Dicrete Orbit.jpg')

[rMatrixECI_small, vMatrixECI_small] = ShellPropagator(r0_vect, v0_vect, Esmallspan, t0, amu);
DrawTraj_3D_small(rMatrixECI, rMatrixECI_small);
% saveas(gcf,'3D Comparison Orbit.jpg')

DrawVelocities(vMatrixECI, tspan)
% saveas(gcf,'Velocity Components.jpg')



