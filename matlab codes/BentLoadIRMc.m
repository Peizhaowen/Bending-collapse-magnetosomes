function [M, Mr, Hcr, Mp, spec] = BentLoadIRMc(x, y, z, d, N, b, H)
    M = zeros(size(H)); 
    Mp = zeros(size(H));
    Hcr = []; 
    Mr = []; 
    spec = zeros(size(H)); 
    if x == 40
        len = 100;
    else
        len = 25;
    end
    for a = 1:len
        [MM, ~, MMr, HHcr,MMp, sspec] = BentLoadOneIRMc(x, y, z, d, N, b, a, H); 
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