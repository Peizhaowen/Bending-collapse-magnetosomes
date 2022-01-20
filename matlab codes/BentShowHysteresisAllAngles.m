function BentShowHysteresisAllAngles(x, y, z, d, N, b)
    H = linspace(-0.3, 0.3, 6001);     
   [M, ~,Mr,~, Hc, Hsw1,Hsw2] = BentLoadHysteresis(x, y, z, d, N, b, H);
        
    BentPlotHysteresis(H, M, Hc, Hsw1, Hsw2); 
    holding = ishold; 
    hold on
    
    Mavg = sum(M) ./ size(M,1);
    plot(H*1000, Mavg, 'b-', 'linewidth', 3);
    plot(-H*1000, -Mavg, 'b-', 'linewidth', 3);
    if holding 
        hold on
    else 
        hold off
    end
    drawnow;
end