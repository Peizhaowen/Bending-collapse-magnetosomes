function Tblocking = BentCalculateBlockingTerror(x, y, z, d, N, b)
% BentCalculateBlockingT(40, 40, 40, 8, 10, 0)
% BentCalculateBlockingTerror(48, 40, 40, 3, 10, 180)
% BentPlotRelaxationTime(100, 100, 100, 3, 10, 0)
% BentPlotRelaxationTime(40, 40, 40, 8, 10, 180)

    T = [0:20:560 575]; 
    [E1, E2, dE] = BentCalculateEnergyBarrier(x, y, z, d, N, b, T);
%     E = (E1 + E2)/2;
    E = dE;
    tau0 = 1e-9; 
    k = 1.38e-23;
    t0 = tau0 * exp( E./(k*(T+273.15)));
    t = log(t0);
    f1 = plot(T, t, 'o');
    hold on;
    
    Teff700 = T(find(t<=100,1));
    Teff = [Teff700:20:560 575];
    [Eeff1, Eeff2] = BentCalculateEnergyBarrier(x, y, z, d, N, b, Teff);
    Eeff = (Eeff1 + Eeff2)/2;
    teff0 = tau0 * exp( Eeff./(k*(Teff+273.15)));
    teff = log(teff0);
    
    fi1 = polyfit(Teff,teff,3);
    Tfit = [Teff700:1:575];
    tfit = polyval(fi1, Tfit);
    Tblocking = Tfit(find(tfit<=2, 1));
    f2 = plot(Tfit, tfit, '-');  
    hold on;
    plot([300,600],[2,2],'k','linewidth',0.5);
    hold on;

end