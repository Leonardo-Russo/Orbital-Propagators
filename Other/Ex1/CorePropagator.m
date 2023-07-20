function [r1_vect, v1_vect, dt] = CorePropagator(r0_vect, v0_vect, dE, amu)
% Description:
% Given position and velocity vectors at time t0, propagates them
% and find the value of those vectors at time t1.

% Initial Conditions Evaluation
coe_0 = rvECI2coe(r0_vect, v0_vect, amu);
nu_0 = coe_0(6);
e_0 = coe_0(2);
a_0 = coe_0(1);

AE_0 = anu2AE(nu_0, e_0);
XM_0 = AE2XM(AE_0, e_0);

% Propagation to E1 = E0 + dE
AE_1 = AE_0 + dE;
XM_1 = AE2XM(AE_1, e_0);

dt = (XM_1-XM_0) * sqrt(a_0^3/amu);     % compute the corresponding dt

nu_1 = AE2anu(AE_1, e_0);   % find new true anomaly since we have moved on the orbit

coe_1 = coe_0;
coe_1(6) = nu_1;            % update the coe vector with the new true anomaly

% Compute r1_vect and v1_vect
[r1_vect, v1_vect] = coe2rvECI(coe_1, amu);

end