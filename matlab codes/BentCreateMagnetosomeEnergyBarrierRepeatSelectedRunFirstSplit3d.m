function BentCreateMagnetosomeEnergyBarrierRepeatSelectedRunFirstSplit3d(x, y, z, d, N, b, r, crystal,T_begin, T_end)
% BentCreateMagnetosomeEnergyBarrierRepeatSelectedRunFirstSplit3d(40, 40, 40, 8, 10, 70, 1, 'co', 460,560)

    modelname = sprintf('3dco_%gx_%gy_%gz_%gd_%dN_%db_%dr', x, y, z, d, N, b,r);
    meshname = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b,r);
    T = [T_begin:20:T_end]; 
    randpath = sprintf('D:/magnetosomes/randangle/randangle.csv');
    fid = fopen(randpath);
    Rand = textscan(fid, ' %f','delimiter',',');
    rand = Rand{1};
    fclose(fid);
    for n = 1:length(T)
         Tname = sprintf('3d%s_%gx_%gy_%gz_%gd_%dN_%db_%dr_%gT', crystal, x, y, z, d, N, b, r, T(n))
         type = 'energy_bent3d';
         [selected_num, split_index] = BentCreateMagnetosomeEnergyBarrierRepeatSelectOneMin(modelname, Tname, type);
         if selected_num ~= 0
             BentCreateMagnetosomeEnergyBarrierRepeatReadZoneandMin3d(modelname, meshname, Tname, T(n),x,y,z,d,N,b,r,rand, selected_num, split_index);
             BentCreateMagnetosomeEnergyBarrierRepeatSelectedRMBatch3d(modelname, Tname, selected_num, split_index)
             for num = 1:5
                 endname1 =  sprintf('%s_p/%s', modelname, Tname);
                 filenamemin = sprintf('Min_%s_%d_%d', Tname,selected_num, split_index);
                 endnamemin =  sprintf('%s/%s', modelname, filenamemin);
                 filename1 = sprintf('%s_%d_%d_1_%d', Tname,selected_num, split_index,num);
                 BentCreateMagnetosomeEnergyBarrierScriptSplit3d(modelname, meshname, filename1, T(n), endname1, endnamemin, x,y,z,d,N,b,r,rand);
                 endname2 =  sprintf('%s_n/%s', modelname, Tname);
                 filename2 = sprintf('%s_%d_%d_2_%d', Tname,selected_num, split_index,num);
                 BentCreateMagnetosomeEnergyBarrierScriptSplit3d(modelname, meshname, filename2, T(n), endnamemin, endname2, x,y,z,d,N,b,r,rand);
             end
              BentCreateMagnetosomeEnergyBarrierRepeatSelectedEBBatch3d(modelname, Tname, selected_num, split_index)
         end
    end 
end