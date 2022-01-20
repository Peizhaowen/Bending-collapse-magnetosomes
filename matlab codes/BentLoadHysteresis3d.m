function [M, Mp, Mr, Mpr, Hc, Hsw1, Hsw2, spec] = BentLoadHysteresis3d(x, y, z, d, N, b, H)
    M = zeros(size(H)); 
    Hc = []; 
    Hsw1 = [];
    Hsw2 = [];
    Mr = []; 
    Mpr = []; 
    spec = zeros(size(H)); 
    
    if x==40
        lena = 10;
    else
        lena = 5;
    end
    for r= 1:10
        for a= 1:lena
            id = a + (r-1)*lena;
            [MM,MMp, ~, ~, MMr, MMpr, HHc, HHsw1, HHsw2, sspec] = BentLoadOneHysteresis3d(x, y, z, d, N, b, r, a, H);
            M(id,:) = MM;
            Mp(id,:) = MMp;
            if ~isnan(MMr)
                Mr(id) = MMr;
                Mpr(id) = MMpr;
                Hc(id) = HHc;
                Hsw1(id) = HHsw1;
                Hsw2(id) = HHsw2;
                spec(id,:) = sspec;
            else
                break;
            end
        end
    end
end