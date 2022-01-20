function BentCreateMagnetosomeEnergyBarrierScript3dSP(x, y, z, d, N, b, r, crystal,rand)
    
    path = 'mesh_bent3d';    
    merrillpath = 'D:/magnetosomes_thermal';
    energy_path = 'energy_bent3d_SP';
    final_path = 'barrier_paths_final_bent3d';
    scriptpath = 'D:/magnetosomes_thermal/scripts/energy_barriers_bent3d_SP';
    subfolder = sprintf('3dco_%gx_%gy_%gz_%gd_%dN_%db_%dr', x, y, z, d, N, b,r);
     meshname = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b,r);

    [~,~,~] = mkdir(scriptpath);
    T = [0:20:560 575];

    for n = 1:length(T)
        filename = sprintf('3d%s_%gx_%gy_%gz_%gd_%dN_%db_%dr_%gT', crystal, x, y, z, d, N, b, r, T(n));
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, energy_path), subfolder);
        fileID = fopen(sprintf('%s/%s.script', scriptpath, filename),'w');
        
        fprintf(fileID, 'Set MaxMeshNumber 1 \n');
        fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', path, meshname);
        
        fprintf(fileID, 'Set MaxEnergyEvaluations 10000 \n');
        fprintf(fileID, 'Set MaxPathEvaluations 1000 \n');
        fprintf(fileID, 'ConjugateGradient \n');
        fprintf(fileID, 'Set ExchangeCalculator 1 \n');
        fprintf(fileID, 'magnetite %g C \n', T(n));
        
        for i = 1:N-1
            Rrot =Bent3dGetAnisaxis(x,y,z,d,N,b,r,i,rand);
            fprintf(fileID, 'CubicAxes %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f SD = %d \n',...
                Rrot(1,1),Rrot(1,2),Rrot(1,3),Rrot(2,1),Rrot(2,2),Rrot(2,3),Rrot(3,1),Rrot(3,2),Rrot(3,3), i);
        end
        fprintf(fileID,'CubicRotation 0 0.6154 -0.7854 SD = 10 \n');
        
        fprintf(fileID, 'ReadTecPlotPath %s/%s/%s \n', ...
            final_path, subfolder, filename);
        fprintf(fileID, 'PathStructureAllComponents %s/%s/%s.dat \n', ...
            energy_path, subfolder, filename);
        fprintf(fileID, 'End \n');
        fprintf(fileID, ' \n');  
        fclose(fileID);
    end
end