function BentCreateMagnetosomeEnergyBarrierRepeatSelectedRunSecSplit3d(x, y, z, d, N, b, r, crystal,T_begin, T_end)
% BentCreateMagnetosomeEnergyBarrierRepeatSelectedRunSecSplit3d(40, 40, 40, 8, 10, 70, 1, 'co', 460,560)
    modelname = sprintf('3dco_%gx_%gy_%gz_%gd_%dN_%db_%dr', x, y, z, d, N, b,r);
    meshname = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b,r);
    T = [T_begin:20:T_end]; 
    randpath = sprintf('D:/magnetosomes/randangle/randangle.csv');
    fid = fopen(randpath);
    Rand = textscan(fid, ' %f','delimiter',',');
    rand = Rand{1};
    fclose(fid);
    for n = 1:length(T)
        Tname = sprintf('3d%s_%gx_%gy_%gz_%gd_%dN_%db_%dr_%gT', crystal, x, y, z, d, N, b, r, T(n));
        type = 'energy_bent3d';
        [selected_num, split_index] = BentCreateMagnetosomeEnergyBarrierRepeatSelectOneMin(modelname, Tname, type);
        Tname21 = sprintf('%s_%d_%d_1', Tname,selected_num, split_index);
        Tname22 = sprintf('%s_%d_%d_2', Tname,selected_num, split_index);
        [selected_num21, split_index21] = BentCreateMagnetosomeEnergyBarrierRepeatSelectOneMin(modelname, Tname21, type);
        [selected_num22, split_index22] = BentCreateMagnetosomeEnergyBarrierRepeatSelectOneMin(modelname, Tname22, type);
        if selected_num21 ~= 0
            BentCreateMagnetosomeEnergyBarrierRepeatReadZoneandMin3d(modelname, meshname, Tname21, T(n),x,y,z,d,N,b,r,rand, selected_num21, split_index21);
            BentCreateMagnetosomeEnergyBarrierRepeatSelectedRMBatch3d(modelname, Tname21, selected_num21, split_index21)
            for num = 1:5
                endname1 =  sprintf('%s_p/%s', modelname, Tname);
                filenamemin21 = sprintf('Min_%s_%d_%d', Tname21,selected_num21, split_index21);
                endnamemin21 =  sprintf('%s/%s', modelname, filenamemin21);
                filename1 = sprintf('%s_%d_%d_1_%d', Tname21,selected_num21, split_index21,num);
                BentCreateMagnetosomeEnergyBarrierScriptSplit3d(modelname, meshname, filename1, T(n), endname1, endnamemin21, x,y,z,d,N,b,r,rand);
                filenamemin = sprintf('Min_%s_%d_%d', Tname,selected_num, split_index);
                endnamemin =  sprintf('%s/%s', modelname, filenamemin);
                filename2 = sprintf('%s_%d_%d_2_%d', Tname21,selected_num21, split_index21,num);
                BentCreateMagnetosomeEnergyBarrierScriptSplit3d(modelname, meshname, filename2, T(n), endnamemin21, endnamemin, x,y,z,d,N,b,r,rand);
            end
            BentCreateMagnetosomeEnergyBarrierRepeatSelectedEBBatch3d(modelname, Tname21, selected_num21, split_index21)
        end
    end 
end