function COE = NuPropagator(COE,dt,mu)
% Description: this propagator integrates true anomaly nu, considering a Keplerian 
% problem. Therefore, all orbit parameters but nu are considered
% constant.
% 
% [r, v] = COEPropagator(COE,dt,mu)

E0 = nu2E(COE(2), COE(6));
M0 = E2M(COE(2), E0);

n=sqrt(mu/(COE(1)^3));      % mean angular motion
M1 = M0 + n*dt;
E1 = M2E(COE(2), M1);
nu1 = E2nu(COE(2), E1);
COE(6) = nu1;

end