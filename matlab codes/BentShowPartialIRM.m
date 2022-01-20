function BentShowPartialIRM(x, y, z, d, N, b, a)
    H = linspace(-0.3, 0, 2000);     
    [M, Mr, Hcr] = BentLoadIRM(x, y, z, d, N, b, H);
    
    if a < length(Hc)
        BentPlotPartialIRM(H, M(a,:)); 
    else
        BentPlotPartialIRM(H, M(a,:)); 
    end
    fprintf('Mr: %g \n', Mr(a));
    fprintf('Hcr: %g \n', Hcr(a));
end