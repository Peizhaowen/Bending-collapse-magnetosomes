function [E1, E2,dE] = BentCalculateEnergyBarrier3dSP(x, y, z, d, N, b, r, T)
% BentCalculateEnergyBarrier3dSP(40, 40, 40, 8, 10, 20,1, 0)
    if nargin < 7
        T = [0:20:560 575]; 
    end
    E1 = NaN(size(T));
    E2 = NaN(size(T));
    dE = NaN(size(T));
    for n = 1:length(T)
        [~,E_this] = BentLoadEnergyBarrier3dSP(x, y, z, d, N, b, r, T(n)); 
        if ~isempty(E_this)
            E1(n) = max(E_this) - E_this(1);
            E2(n) = max(E_this) - E_this(end);
            %dE(n) = max(E_this)-min(E_this);
            dE(n) = (E1(n) + E2(n))/2;
        end
    end
    
end