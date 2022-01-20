function BentShowHysteresis3d(x, y, z, d, N, b, r, a)
% BentShowHysteresis3d(100, 100, 100, 3, 10, 0, 1, 1)
% BentShowHysteresis3d(40, 40, 40, 8, 10, 70, 1, 1)
    H = linspace(-0.3, 0.3, 2000);     
    [MM, ~,~,~,MMr,~, HHc, HHsw1,HHsw2] = BentLoadOneHysteresis3d(x, y, z, d, N, b, r, a, H);
    M(a,:) = MM;
    Mr(a) = MMr;
    Hc(a) = HHc; 
    Hsw1(a) = HHsw1; 
    Hsw2(a) = HHsw2; 
    BentPlotHysteresis(H, M(a,:), Hc(a), Hsw1(a),Hsw2(a)); 

    fprintf('Mr: %g \n', Mr(a));
    fprintf('Hc: %g \n', Hc(a));
    fprintf('Hsw1: %g \n', Hsw1(a));
    fprintf('Hsw2: %g \n', Hsw2(a));
end