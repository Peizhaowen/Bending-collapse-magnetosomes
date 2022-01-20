function [E1, E2, dE] = BentCalculateEnergyBarrier(x, y, z, d, N, b, T,crystal)
    if nargin < 7
        T = [0:20:560 575]; 
    end
    E1 = NaN(size(T));
    E2 = NaN(size(T));
    dE = NaN(size(T));
    for n = 1:length(T)
        E_this = BentLoadEnergyBarrier(x, y, z, d, N, b, T(n),crystal);
        if ~isempty(E_this)
            E1(n) = max(E_this) - E_this(1);
            E2(n) = max(E_this) - E_this(end);
           %dE(n) = max(E_this)-min(E_this);
            dE(n) = (E1(n) + E2(n))/2;
        end
    end
    
end