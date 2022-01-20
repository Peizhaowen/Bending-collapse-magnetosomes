function BentShowIRMc(x, y, z, d, N, b, a)
    H = linspace(-0.3, 0, 1000);     
    [M, Mr, Hcr] = BentLoadIRMc(x, y, z, d, N, b, H);
    
    if a < length(Hcr)
        BentPlotIRMc(H, M(a,:), Hcr(a)); 
    else
        BentPlotIRMc(H, M(a,:)); 
    end
    fprintf('Mr: %g \n', Mr(a));
    fprintf('Hcr: %g \n', Hcr(a));
end