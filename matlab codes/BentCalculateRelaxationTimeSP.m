function t = BentCalculateRelaxationTimeSP(x, y, z, d, N, b, crystal)
    [~, ~,dE] = BentCalculateEnergyBarrierSP(x, y, z, d, N, b, 20, crystal);
    E = dE;
    tau0 = 1e-9; 
    k = 1.38e-23;
    t0 = tau0 * exp(E/(k*(20+273.15))) / 3600 / 365 /24;
    t = log10(t0);
end