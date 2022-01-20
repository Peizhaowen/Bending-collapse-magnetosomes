function BentPlotRelaxationTime(x, y, z, d, N, b)
% BentPlotRelaxationTime(40, 40, 40, 8, 10, 0)
% BentPlotRelaxationTime(48, 40, 40, 3, 10, 180)
% BentPlotRelaxationTime(100, 100, 100, 3, 10, 0)
% BentPlotRelaxationTime(40, 40, 40, 8, 10, 180)
    T = [0:20:560 575]; 
    [E1, E2] = BentCalculateEnergyBarrier(x, y, z, d, N, b, T);
    E = (E1 + E2)/2;
    tau0 = 1e-10; 
    k = 1.38e-23;
    t = tau0 * exp( E./(k*(T+273.15)));
    f1 = semilogy(T, t, 'o-');
    l1= legend(f1,'Cube-40-40-40-8-10');
    set(l1,'Fontsize',15);
    hold on;
end