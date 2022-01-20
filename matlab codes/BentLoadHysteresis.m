function [M, Mp, Mr, Mpr, Hc, Hsw1, Hsw2, spec] = BentLoadHysteresis(x, y, z, d, N, b, H)
    M = zeros(size(H)); 
    Hc = []; 
    Hsw1 = [];
    Hsw2 = [];
    Mr = []; 
    Mpr = []; 
    spec = zeros(size(H)); 
        
    for a = 1:100
        [MM,MMp, ~, ~, MMr, MMpr, HHc, HHsw1, HHsw2, sspec] = BentLoadOneHysteresis(x, y, z, d, N, b, a, H); 
        M(a,:) = MM;
        Mp(a,:) = MMp;
        if ~isnan(MMr)
            Mr(a) = MMr;
            Mpr(a) = MMpr;
            Hc(a) = HHc; 
            Hsw1(a) = HHsw1; 
            Hsw2(a) = HHsw2; 
            spec(a,:) = sspec; 
        else 
            break;
        end
    end
end