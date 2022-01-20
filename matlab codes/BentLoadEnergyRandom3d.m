function E = BentLoadEnergyRandom3d(x, y, z, d, N, b, r, T,crystal)
% BentLoadEnergyRandom(40, 40, 40, 8, 10, 324,20,'co')
    E=[];
    for i = 1:100
        [~, E(i)] = BentLoadOneEnergyRandom3d(x, y, z, d, N, b, r,i,T,crystal);
    end
    E(101) = BentLoadOneEnergyRandom3d(x, y, z, d, N, b, r, 1, T, crystal);
end