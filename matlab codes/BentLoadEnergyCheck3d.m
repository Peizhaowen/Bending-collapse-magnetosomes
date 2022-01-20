function E = BentLoadEnergyCheck3d(x, y, z, d, N, b, T,crystal)
% BentLoadEnergyCheck3d(40, 40, 40, 8, 10, 70,20,'co')
    E=[];
    E(1) = BentLoadOneEnergyCheck3d(x, y, z, d, N, b,1,1,T,crystal);
    for r = 1:10
        for a = 1:10
            id = a + (r-1)*10 +1;
            [~, E(id)] = BentLoadOneEnergyCheck3d(x, y, z, d, N, b, r,a,T,crystal);
        end
    end
end