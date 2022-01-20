function [M, Mr, Hcr, Mp, spec] = BentLoadIRM(x, y, z, d, N, b, H)
    M = zeros(size(H)); 
    Mp = zeros(size(H));
    Hcr = []; 
    Mr = []; 
    spec = zeros(size(H)); 
        
    for a = 1:100
        [MM, ~, MMr, HHcr, MMp,sspec] = BentLoadOneIRM(x, y, z, d, N, b, a, H); 
        M(a,:) = MM;
        Mp(a,:) = MMp;
        if ~isnan(MMr)
            Mr(a) = MMr;
            Hcr(a) = HHcr;
            spec(a,:) = sspec; 
        else 
            break;
        end
    end
end