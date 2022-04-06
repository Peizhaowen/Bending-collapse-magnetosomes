function BentCreateMagnetosomeEnergyBarrierRepeatSelectedRunSecondSplit(x, y, z, d, N, b, crystal,T_begin)
% BentCreateMagnetosomeEnergyBarrierRepeatSelectedRunFirstSplit(40, 40, 40, 8, 10, 0, 'co')
    if crystal == 'c'
        modelname = sprintf('%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
    end
    if crystal == 'co'
        modelname = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
    end
    
    T = [T_begin:20:560 575];
    for n = 1:length(T)
        Tname = sprintf('%s_%gx_%gy_%gz_%gd_%dN_%db_%gT', crystal, x, y, z, d, N, b, T(n));
        [selected_num, split_index] = BentCreateMagnetosomeEnergyBarrierRepeatSelectOneMin(modelname, Tname);
        Tname21 = sprintf('%s_%d_%d_1', Tname,selected_num, split_index);
        Tname22 = sprintf('%s_%d_%d_2', Tname,selected_num, split_index);
        [selected_num21, split_index21] = BentCreateMagnetosomeEnergyBarrierRepeatSelectOneMin(modelname, Tname21);
        [selected_num22, split_index22] = BentCreateMagnetosomeEnergyBarrierRepeatSelectOneMin(modelname, Tname22);
        if selected_num21 ~= 0
            
        end
        
        if selected_num22 ~= 0
            
        end
    end
end