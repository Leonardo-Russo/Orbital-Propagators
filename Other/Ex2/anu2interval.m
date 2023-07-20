function Dt = anu2interval(nu_1, nu_2, a, e, amu)
% Description:
% Find the time interval between two positions on the same orbit described
% by two values of true anomaly.

E_1 = anu2AE(nu_1, e);
E_2 = anu2AE(nu_2, e);
M_1 = AE2XM(E_1, e);
M_2 = AE2XM(E_2, e);

Dt = sqrt(a^3/amu) * (M_2 - M_1);

end