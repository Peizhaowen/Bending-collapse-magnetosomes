function BentShowIRM(x, y, z, d, N, b, a)
    H = linspace(-0.3, 0, 1000);     
    [M, Mr, Hcr] = BentLoadIRM(x, y, z, d, N, b, H);
    
    if a < length(Hcr)
        BentPlotIRM(H, M(a,:), Hcr(a)); 
    else
        BentPlotIRM(H, M(a,:)); 
    end
    fprintf('Mr: %g \n', Mr(a));
    fprintf('Hcr: %g \n', Hcr(a));
end