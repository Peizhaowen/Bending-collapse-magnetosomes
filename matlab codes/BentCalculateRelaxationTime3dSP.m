function t = BentCalculateRelaxationTime3dSP(x, y, z, d, N, b, r)
% BentCalculateRelaxationTime3dSP(40, 40, 40, 8, 10, 20,1)
    [E1, E2,dE] = BentCalculateEnergyBarrier3dSP(x, y, z, d, N, b, r, 20);
    E = dE;
    tau0 = 1e-9; 
    k = 1.38e-23;
    t0 = tau0 * exp(E/(k*(20+273.15))) / 3600 / 365 /24;
    t = log10(t0);
end