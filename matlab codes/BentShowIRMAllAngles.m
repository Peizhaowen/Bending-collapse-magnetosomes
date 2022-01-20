function BentShowIRMAllAngles(x, y, z, d, N, b)
    
    H = linspace(-0.3, 0, 1000);     
    [M, Mr, Hcr,Mp, spec] = BentLoadIRM(x, y, z, d, N, b, H);
        
    BentPlotIRM(H, M, Hcr); 
    
    holding = ishold; 
    hold on
    
    Mavg = sum(M) ./ size(M,1);
    plot(H*1000, Mavg, 'b-', 'linewidth', 3);
    if holding 
        hold on
    else 
        hold off
    end
    
    drawnow;
    
end