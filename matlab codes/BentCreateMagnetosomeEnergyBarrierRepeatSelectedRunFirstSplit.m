function BentCreateMagnetosomeEnergyBarrierRepeatSelectedRunFirstSplit(x, y, z, d, N, b, crystal,T_begin)
% BentCreateMagnetosomeEnergyBarrierRepeatSelectedRunFirstSplit(40, 40, 40, 8, 10, 0, 'co', 520)
    if crystal == 'c'
        modelname = sprintf('%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
    end
    if crystal == 'co'
        modelname = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
    end    
    T = [T_begin:20:560 575]; 
    meshname = sprintf('magnetosome_%s', modelname);
    
    for n = 1:length(T)
         Tname = sprintf('%s_%gx_%gy_%gz_%gd_%dN_%db_%gT', crystal, x, y, z, d, N, b, T(n))
         type = 'energy_bent';
         [selected_num, split_index] = BentCreateMagnetosomeEnergyBarrierRepeatSelectOneMin(modelname, Tname, type);
         if selected_num ~= 0
             BentCreateMagnetosomeEnergyBarrierRepeatReadZoneandMin(modelname, meshname, Tname, T(n), b, selected_num, split_index);
             BentCreateMagnetosomeEnergyBarrierRepeatSelectedRMBatch(modelname, Tname, selected_num, split_index)
             for num = 1:5
                 endname1 =  sprintf('%s_p/%s', modelname, Tname);
                 filenamemin = sprintf('Min_%s_%d_%d', Tname,selected_num, split_index);
                 endnamemin =  sprintf('%s/%s', modelname, filenamemin);
                 filename1 = sprintf('%s_%d_%d_1_%d', Tname,selected_num, split_index,num);
                 BentCreateMagnetosomeEnergyBarrierScriptSplit(modelname, meshname, filename1, T(n), b, endname1, endnamemin);
                 endname2 =  sprintf('%s_n/%s', modelname, Tname);
                 filename2 = sprintf('%s_%d_%d_2_%d', Tname,selected_num, split_index,num);
                 BentCreateMagnetosomeEnergyBarrierScriptSplit(modelname, meshname, filename2, T(n), b, endnamemin, endname2);
             end
             BentCreateMagnetosomeEnergyBarrierRepeatSelectedEBBatch(modelname, Tname, selected_num, split_index)
         end
    end 
end