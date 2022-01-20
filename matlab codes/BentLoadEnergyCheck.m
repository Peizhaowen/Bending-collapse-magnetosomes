function E = BentLoadEnergyCheck(x, y, z, d, N, b, T,crystal)
% BentLoadEnergyCheck(40, 40, 40, 8, 10, 324,20,'co')
    E=[];
    E(1) = BentLoadOneEnergyCheck(x, y, z, d, N, b,1,T,crystal);
    for i = 2:101
        [~, E(i)] = BentLoadOneEnergyCheck(x, y, z, d, N, b, i-1,T,crystal);
    end
end