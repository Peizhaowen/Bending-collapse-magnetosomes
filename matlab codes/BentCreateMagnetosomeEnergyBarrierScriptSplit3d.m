function BentCreateMagnetosomeEnergyBarrierScriptSplit3d(modelname, meshname, filename, T, endname1, endname2,x,y,z,d,N,b,r,rand)
    
    path = 'mesh_bent3d';
    groundstatepath = 'groundstates_bent3d';
    inital_path = 'barrier_paths_initial_bent3d';
    final_path = 'barrier_paths_final_bent3d';
    energy_path = 'energy_bent3d';
    energylog_initial_path = 'energylog_initial_bent3d';
    energylog_final_path = 'energylog_final_bent3d';
    scriptpath = 'D:/magnetosomes_thermal/scripts/energy_barriers_bent3d';
    subfolder = modelname;
    [~,~,~] = mkdir(scriptpath);
    
    fileID = fopen(sprintf('%s/%s.script', scriptpath, filename),'w');
    fprintf(fileID, 'Set MaxMeshNumber 1 \n');
    fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', path, meshname);
    for i = 1:N-1
        Rrot =Bent3dGetAnisaxis(x,y,z,d,N,b,r,i,rand);
        fprintf(fileID, 'CubicAxes %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f SD = %d \n',...
            Rrot(1,1),Rrot(1,2),Rrot(1,3),Rrot(2,1),Rrot(2,2),Rrot(2,3),Rrot(3,1),Rrot(3,2),Rrot(3,3), i);
    end
    fprintf(fileID,'CubicRotation 0 0.6154 -0.7854 SD = 10 \n');

    fprintf(fileID, 'Set MaxEnergyEvaluations 10000 \n');
    fprintf(fileID, 'Set MaxPathEvaluations 5000 \n');
    fprintf(fileID, 'ConjugateGradient \n');
    fprintf(fileID, 'Set ExchangeCalculator 1 \n');
    fprintf(fileID, 'magnetite %g C \n', T);

    fprintf(fileID, 'Set PathN 2 \n');
    fprintf(fileID, 'ReadMagnetization %s/%s.dat \n', ...
        groundstatepath, endname1);
    fprintf(fileID, 'MagnetizationToPath 1 \n');
    fprintf(fileID, 'ReadMagnetization %s/%s.dat \n', ...
        groundstatepath, endname2);
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
    fprintf(fileID, 'magnetite %g C \n', T);
    fprintf(fileID, 'EnergyLog %s/%s/%s \n', ...
        energylog_final_path, subfolder, filename);
    fprintf(fileID, 'PathMinimize \n');
    fprintf(fileID, 'CloseLogFile \n');
    fprintf(fileID, 'WriteTecPlotPath %s/%s/%s \n', ...
        final_path, subfolder, filename);

    fprintf(fileID, 'ReadTecPlotPath %s/%s/%s \n', ...
        final_path, subfolder, filename);
    fprintf(fileID, 'magnetite %g C \n', T);
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