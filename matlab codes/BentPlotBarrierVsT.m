function BentPlotBarrierVsT(x, y, z, d, b, N)
    T = [0:20:560 575]; 
    k = 1.38e-23;
    [E1, E2] = BentCalculateEnergyBarrier(x, y, z, d, N, b, T);
    plot(T, E1/k, 'o-', T, E2/k, 's-');
end