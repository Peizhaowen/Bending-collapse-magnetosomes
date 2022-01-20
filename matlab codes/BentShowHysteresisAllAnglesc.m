function BentShowHysteresisAllAnglesc(x, y, z, d, N, b)
    
% BentShowHysteresisAllAnglesc(100, 100, 100, 3, 10, 0)
% BentShowHysteresisAllAnglesc(40, 40, 40, 8, 10, 300)

    H = linspace(-0.3, 0.3, 6001);     
    [M, Mp, Mr, Mpr, Hc, Hsw1, Hsw2, spec] = BentLoadHysteresisc(x, y, z, d, N, b, H);
        
    BentPlotHysteresis(H, Mp, Hc, Hsw1, Hsw2); 
    
    holding = ishold; 
    hold on
    
    Mavg = sum(Mp) ./ size(Mp,1);
    plot(H*1000, Mavg, 'b-', 'linewidth', 3);
    plot(-H*1000, -Mavg, 'b-', 'linewidth', 3);
    if holding 
        hold on
    else 
        hold off
    end
    
    drawnow;
    
end