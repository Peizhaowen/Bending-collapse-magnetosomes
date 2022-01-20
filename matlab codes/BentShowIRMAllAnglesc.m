function BentShowIRMAllAnglesc(x, y, z, d, N, b)
    % BentShowIRMAllAnglesc(100, 100, 100, 3, 10, 0)
    H = linspace(-0.3, 0, 1000);     
    [M, Mr, Hcr, spec] = BentLoadIRMc(x, y, z, d, N, b, H);
        
    BentPlotIRMc(H, M, Hcr); 
    
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