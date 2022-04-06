function BentCreateMagnetosomeEnergyBarrierScript3dRepeat(x, y, z, d, N, b, r, crystal, rand, num)
    path = 'mesh_bent3d';
    groundstatepath = 'groundstates_bent3d';
    merrillpath = 'D:/magnetosomes_thermal';
    inital_path = 'barrier_paths_initial_bent3d';
    final_path = 'barrier_paths_final_bent3d';
    energy_path = 'energy_bent3d';
    energylog_initial_path = 'energylog_initial_bent3d';
    energylog_final_path = 'energylog_final_bent3d';
    scriptpath = 'D:/magnetosomes_thermal/scripts/energy_barriers_bent3d';

    subfolder = sprintf('3dco_%gx_%gy_%gz_%gd_%dN_%db_%dr', x, y, z, d, N, b,r);
    meshname = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b,r);

    [~,~,~] = mkdir(scriptpath);
    T = [0:20:560 575];

    for n = 1:length(T)
        filename = sprintf('3d%s_%gx_%gy_%gz_%gd_%dN_%db_%dr_%gT_%d', crystal, x, y, z, d, N, b, r, T(n), num);
        filename0 = sprintf('3d%s_%gx_%gy_%gz_%gd_%dN_%db_%dr_%gT', crystal, x, y, z, d, N, b, r, T(n));

        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, energylog_initial_path), subfolder); 
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, energylog_final_path), subfolder); 
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, energy_path), subfolder); 
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, inital_path), subfolder); 
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, final_path), subfolder); 

        fileID = fopen(sprintf('%s/%s.script', scriptpath, filename),'w');

        fprintf(fileID, 'Set MaxMeshNumber 1 \n'); 
        fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', path, meshname);
        
        fprintf(fileID, 'Set MaxEnergyEvaluations 10000 \n');
        fprintf(fileID, 'Set MaxPathEvaluations 5000 \n'); 
        fprintf(fileID, 'ConjugateGradient \n'); 
        fprintf(fileID, 'Set ExchangeCalculator 1 \n'); 
        fprintf(fileID, 'magnetite %g C \n', T(n));
        
        for i = 1:N-1
            Rrot =Bent3dGetAnisaxis(x,y,z,d,N,b,r,i,rand);
            fprintf(fileID, 'CubicAxes %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f SD = %d \n',...
                Rrot(1,1),Rrot(1,2),Rrot(1,3),Rrot(2,1),Rrot(2,2),Rrot(2,3),Rrot(3,1),Rrot(3,2),Rrot(3,3), i);
        end
        fprintf(fileID,'CubicRotation 0 0.6154 -0.7854 SD = 10 \n');
        
        fprintf(fileID, 'Set PathN 2 \n'); 
        fprintf(fileID, 'ReadMagnetization %s/%s_p/%s.dat \n', ...
            groundstatepath, subfolder, filename0); 
        fprintf(fileID, 'MagnetizationToPath 1 \n'); 
        fprintf(fileID, 'ReadMagnetization %s/%s_n/%s.dat \n', ...
            groundstatepath, subfolder, filename0); 
        fprintf(fileID, 'MagnetizationToPath 2 \n'); 
        
        fprintf(fileID, 'EnergyLog %s/%s/%s \n', ...
            energylog_initial_path, subfolder, filename); 
        fprintf(fileID, 'RefinePathTo 50 \n'); 
        fprintf(fileID, 'MakeInitialPath \n'); 
        fprintf(fileID, 'WriteTecPlotPath %s/%s/%s \n', ...
            inital_path, subfolder, filename); 
        fprintf(fileID, 'CloseLogFile \n'); 
        
        fprintf(fileID, 'ReadTecPlotPath %s/%s/%s \n', ...
            inital_path, subfolder, filename); 
        fprintf(fileID, 'Set MaxEnergyEvaluations 10000 \n');
        fprintf(fileID, 'ConjugateGradient \n'); 
        fprintf(fileID, 'Set ExchangeCalculator 1 \n'); 
        fprintf(fileID, 'magnetite %g C \n', T(n));
        fprintf(fileID, 'EnergyLog %s/%s/%s \n', ...
            energylog_final_path, subfolder, filename); 
        fprintf(fileID, 'PathMinimize \n'); 
        fprintf(fileID, 'CloseLogFile \n'); 
        fprintf(fileID, 'WriteTecPlotPath %s/%s/%s \n', ...
            final_path, subfolder, filename); 
        
        fprintf(fileID, 'ReadTecPlotPath %s/%s/%s \n', ...
            final_path, subfolder, filename);
        fprintf(fileID, 'magnetite %g C \n', T(n));
        
        for i = 1:N-1
            Rrot =Bent3dGetAnisaxis(x,y,z,d,N,b,r,i,rand);
            fprintf(fileID, 'CubicAxes %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f SD = %d \n',...
                Rrot(1,1),Rrot(1,2),Rrot(1,3),Rrot(2,1),Rrot(2,2),Rrot(2,3),Rrot(3,1),Rrot(3,2),Rrot(3,3), i);
        end
        fprintf(fileID,'CubicRotation 0 0.6154 -0.7854 SD = 10 \n');
        
        fprintf(fileID, 'PathStructureEnergies %s/%s/%s.dat \n', ...
            energy_path, subfolder, filename);
        fprintf(fileID, 'End \n');
        fprintf(fileID, ' \n');
        
        fclose(fileID);
    end
end