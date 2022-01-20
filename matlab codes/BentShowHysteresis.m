function BentShowHysteresis(x, y, z, d, N, b, a)
%

    H = linspace(-0.3, 0.3, 2000);     
    [M, ~,Mr,~, Hc, Hsw1,Hsw2] = BentLoadHysteresis(x, y, z, d, N, b, H);
    
    if a < length(Hc)
        BentPlotHysteresis(H, M(a,:), Hc(a), Hsw1(a),Hsw2(a)); 
    else
        BentPlotHysteresis(H, M(a,:)); 
    end
    fprintf('Mr: %g \n', Mr(a));
    fprintf('Hc: %g \n', Hc(a));
    fprintf('Hsw1: %g \n', Hsw1(a));
    fprintf('Hsw2: %g \n', Hsw2(a));
end