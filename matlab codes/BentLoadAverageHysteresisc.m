function [Mavg, Hc, Mr, Mpr,Mavgp] = BentLoadAverageHysteresisc(x, y, z, d, N, b, H)
     [M, Mp, ~, ~,~,~,~,~] = BentLoadHysteresisc(x, y, z, d, N, b, H); 
    n = size(M,1);
    
    Mavg = sum(M) ./ n;
    Mavgp = sum(Mp) ./ n;
    idx = find(Mavg >= 0, 1, 'first');
    if isempty(idx) || idx < 2
        Hc = [];
    else
        Hc = H(idx); 
    end
    
    idx = find(H>=0, 1, 'first'); 
    Mr = -Mavg(idx); 
    Mpr = -Mavgp(idx); 
end