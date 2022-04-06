function BentCreateMagnetosomeEnergyBarrierScriptRepeat(x, y, z, d, N, b, crystal, num)
    path = 'mesh_bent'; 
    groundstatepath = 'groundstates_bent'; 
    merrillpath = 'D:/magnetosomes_thermal'; 
    inital_path = 'barrier_paths_initial_bent'; 
    final_path = 'barrier_paths_final_bent'; 
    energy_path = 'energy_bent'; 
    energylog_initial_path = 'energylog_initial_bent';
    energylog_final_path = 'energylog_final_bent';
    scriptpath = 'D:/magnetosomes_thermal/scripts/energy_barriers_bent'; 
    
    if crystal == 'c'
        subfolder = sprintf('%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
        meshname = sprintf('magnetosome_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    end
    
    if crystal == 'co'
        subfolder = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
        meshname = sprintf('magnetosome_Cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    end
    
    [~,~,~] = mkdir(scriptpath); 
    T = [0:20:560 575]; 
    
    for n = 1:length(T)
        filename = sprintf('%s_%gx_%gy_%gz_%gd_%dN_%db_%gT_%d', crystal, x, y, z, d, N, b, T(n),num);
        filename0 = sprintf('%s_%gx_%gy_%gz_%gd_%dN_%db_%gT', crystal, x, y, z, d, N, b, T(n));

        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, energylog_initial_path), subfolder); 
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, energylog_final_path), subfolder); 
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, energy_path), subfolder); 
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, inital_path), subfolder); 
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, final_path), subfolder); 

        fileID = fopen(sprintf('%s/%s.script', scriptpath, filename),'w');
        
        fprintf(fileID, 'Set MaxMeshNumber 1 \n');
        fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', path, meshname);
        
        for i = 1:10
            rotangley = (b*(-i+5.5)/(N-1))*pi/180;
            fprintf(fileID, 'CubicRotation 0 %1.4f %1.4f SD = %d \n',rotangley+0.6154,-0.7854,i);
        end
        
        fprintf(fileID, 'Set MaxEnergyEvaluations 10000 \n');
        fprintf(fileID, 'Set MaxPathEvaluations 5000 \n'); 
        fprintf(fileID, 'ConjugateGradient \n'); 
        fprintf(fileID, 'Set ExchangeCalculator 1 \n'); 
        fprintf(fileID, 'magnetite %g C \n', T(n));
        
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
        for i = 1:10
            rotangley = (b*(-i+5.5)/(N-1))*pi/180;
            fprintf(fileID, 'CubicRotation 0 %1.4f %1.4f SD = %d \n',rotangley+0.6154,-0.7854,i);
        end
        fprintf(fileID, 'PathStructureEnergies %s/%s/%s.dat \n', ...
            energy_path, subfolder, filename);
        fprintf(fileID, 'End \n');
        fprintf(fileID, ' \n');  
        
        fclose(fileID);
    end
end