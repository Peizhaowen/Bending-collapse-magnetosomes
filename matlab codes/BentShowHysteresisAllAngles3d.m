function BentShowHysteresisAllAngles3d(x, y, z, d, N, b)
    % BentShowHysteresisAllAngles3d(40, 40, 40, 8, 10, 70)
    H = linspace(-0.3, 0.3, 6001);     
   [M, Mp,Mr,~, Hc, Hsw1,Hsw2] = BentLoadHysteresis3d(x, y, z, d, N, b, H);
        
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