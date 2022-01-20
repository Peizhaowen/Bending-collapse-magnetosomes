function [Mavg, Hcr, Mr, Mpavg] = BentLoadAverageIRMc(x, y, z, d, N, b, H)
    [M, ~,~ ,Mp]= BentLoadIRMc(x, y, z, d, N, b, H);
    n = size(M,1);
    
    Mavg = sum(M) ./ n;
    Mpavg = sum(Mp) ./ n;
    idx = find(Mavg >= 0, 1, 'first');
    if isempty(idx) || idx < 2
        Hcr = [];
    else
        Hcr = H(idx);
    end
    
    idx1 = find(H>=0, 1, 'first');
    Mr = Mavg(idx1); 
end