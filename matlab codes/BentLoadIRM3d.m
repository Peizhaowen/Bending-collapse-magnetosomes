function [M, Mr, Hcr,  Mp,spec] = BentLoadIRM3d(x, y, z, d, N, b, H)
    M = zeros(size(H)); 
    Mp = zeros(size(H));
    Hcr = []; 
    Mr = []; 
    spec = zeros(size(H)); 
        
    if x==40
        lena = 10;
    else
        lena = 5;
    end
    for r= 1:10
        for a= 1:lena
            id = a + (r-1)*lena;
            [MM, ~, MMr, HHcr, MMp,sspec] = BentLoadOneIRM3d(x, y, z, d, N, b, r, a, H);
            M(id,:) = MM;
            Mp(id,:) = MMp;
            if ~isnan(MMr)
                Mr(id) = MMr;
                Hcr(id) = HHcr;
                spec(id,:) = sspec;
            else
                break;
            end
        end
    end
end