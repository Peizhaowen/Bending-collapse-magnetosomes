function Tblocking = BentCalculateBlockingT3dSP(x, y, z, d, N, b, r)
% BentCalculateBlockingT3dSP(40, 40, 40, 8, 10, 20,1)

    T = [0:20:560 575]; 
    [E1, E2,dE] = BentCalculateEnergyBarrier3dSP(x, y, z, d, N, b, r, T);
%     E = (E1 + E2)/2;
    E = dE;
    tau0 = 1e-9; 
    k = 1.38e-23;
    t0 = tau0 * exp( E./(k*(T+273.15)));
    t = log10(t0);
    f1 = plot(T, t, 'o');
    hold on;
    
    Teff700 = T(find(t<=20,1));
    Teff = [Teff700:20:560 575];
    [Eeff1, Eeff2,dEeff] = BentCalculateEnergyBarrier3dSP(x, y, z, d, N, b, r,Teff);
    Eeff(1) = dEeff(1);
    for i = 2:length(dEeff)-1
       if dEeff(i) > dEeff(i-1)*3
           Eeff(i) = 0.5*(dEeff(i-1)+dEeff(i+1));
       else
           Eeff(i) = dEeff(i);
       end
    end
    Eeff(length(dEeff)) = dEeff(length(dEeff)); 
    teff0 = tau0 * exp( Eeff./(k*(Teff+273.15)));
    teff = log10(teff0);
    
    fi1 = polyfit(Teff,teff,3);
    Tfit = [Teff700:1:575];
    tfit = polyval(fi1, Tfit);
    if Tfit(find(tfit<=2, 1)) > 0
        Tblocking = Tfit(find(tfit<=2, 1));
    else
        Tblocking = BentCalculateBlockingT3dSP(x, y, z, d, N, b,r-1);
    end
    
    f2 = plot(Tfit, tfit, '-');  
    hold on;
    plot([300,600],[2,2],'k','linewidth',0.5);
    hold on;

end