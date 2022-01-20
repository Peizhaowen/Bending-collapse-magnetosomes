function t = BentCalculateRelaxationTime(x, y, z, d, N, b, crystal)
% BentCalculateRelaxationTime(40, 40, 40, 8, 10, 30,'c')
    [E1, E2,dE] = BentCalculateEnergyBarrier(x, y, z, d, N, b, 20, crystal);
    E = dE;
    tau0 = 1e-9; 
    k = 1.38e-23;
    E/(k*(20+273.15))
    t0 = tau0 * exp(E/(k*(20+273.15))) / 3600 / 365 /24
    t = log10(t0);
end