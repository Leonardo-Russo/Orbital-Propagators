function r_vectECEF = ECI2ECEF(MJD, r_vectECI)
% Description:
% Transformation from ECI reference frame into ECEF.
% To perform this operation it is necessary to know the position
% of Greenwich's meridian, which can be found from the knowledge of
% the MJD given as input.
% Note that the initial value of alpha_greenwich is given on day
% 01/01/1995 at 00:00:00.

% Note:
% Ground Track corresponds to ECEF coordinates in polar form.
% All angles are in [rad].

D_sidereal = 86164;      % s

alpha_grw0 = 100 * pi() / 180;       % rad - it was given in degrees
omega_earth = 2*pi() / D_sidereal;   % rad/s

alpha_grw = alpha_grw0 + omega_earth * MJD;

% then, we only have to rotate by the angle alpha_grw   ???

% Rotation of the r_vectECI by means of matrix R
R_ECI2ECEF = [cos(alpha_grw) sin(alpha_grw) 0;...
              -sin(alpha_grw) cos(alpha_grw) 0;...
              0 0 1];

% then, we can obtain the final position vector
r_vectECEF = R_ECI2ECEF * r_vectECI;
