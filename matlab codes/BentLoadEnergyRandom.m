function E = BentLoadEnergyRandom(x, y, z, d, N, b, T,crystal)
    % BentLoadEnergyRandom(40, 40, 40, 8, 10, 324,20,'co')
    E=[];
    for i = 1:100
        [~, E(i)] = BentLoadOneEnergyRandom(x, y, z, d, N, b, i,T,crystal);
    end
    E(101) = BentLoadOneEnergyRandom(x, y, z, d, N, b,1,T,crystal);
end