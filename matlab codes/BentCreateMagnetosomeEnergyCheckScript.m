function filename = BentCreateMagnetosomeEnergyCheckScript(x, y, z, d, N, b, a, crystal,theta,phi)
    path = 'mesh_bent'; 
    groundstatepath0 = 'groundstates_bent'; 
    groundstatepath = 'groundstates_bent_other';
    merrillpath = 'D:/magnetosomes_thermal'; 
    inital_path = 'barrier_paths_initial_bent_other'; 
    final_path = 'barrier_paths_final_bent_other'; 
    energy_path = 'energy_bent_other'; 
    energylog_initial_path = 'energylog_initial_bent_other';
    energylog_final_path = 'energylog_final_bent_other';
    scriptpath = 'D:/magnetosomes_thermal/scripts/energy_barriers_bent_other'; 
    if crystal == 'c'
        subfolder0 = sprintf('%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
        subfolder = sprintf('%gx_%gy_%gz_%gd_%dN_%db_%da', x, y, z, d, N, b, a);
        meshname = sprintf('magnetosome_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    end
    if crystal == 'co'
        subfolder0 = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
        subfolder = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_%db_%da', x, y, z, d, N, b, a);
        meshname = sprintf('magnetosome_Cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    end
    [~,~,~] = mkdir(scriptpath);
    T = [0:20:560 575];
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, energylog_initial_path), subfolder);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, energylog_final_path), subfolder);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, energy_path), subfolder);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, inital_path), subfolder);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, final_path), subfolder);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, groundstatepath), subfolder);
    T = 20;
    filename = sprintf('%s_%gx_%gy_%gz_%gd_%dN_%db_%gT_%da', crystal, x, y, z, d, N, b, T, a);
    filename0 = sprintf('%s_%gx_%gy_%gz_%gd_%dN_%db_%gT', crystal, x, y, z, d, N, b, T);
    fileID = fopen(sprintf('%s/%s.script', scriptpath, filename),'w');
    % calculate SIRM state
    fprintf(fileID, 'magnetite %g C \n', T);
    fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', path, meshname);
    angx = cos(theta/180*pi);
    angy = sin(theta/180*pi)*cos(phi/180*pi);
    angz = sin(theta/180*pi)*sin(phi/180*pi);
    for i = 1:10
        rotangley = (b*(-i+5.5)/(N-1))*pi/180;
        fprintf(fileID, 'CubicRotation 0 %1.4f %1.4f SD = %d \n',rotangley+0.6154,-0.7854,i);
    end
    fprintf(fileID, '!angle #%d (theta=%d, phi=%d) \n', ...
        a, round(theta), round(phi));
    fprintf(fileID, 'Set MaxEnergyEvaluations 20000 \n');
    fprintf(fileID, 'external field direction %1.3f %1.3f %1.3f \n', angx, angy, angz);
    fprintf(fileID, 'Uniform Magnetization %1.3f %1.3f %1.3f \n', angx, angy, angz);
    fprintf(fileID, 'Randomize Magnetization 10 \n');
    fprintf(fileID, 'External field strength 0 mT  \n');
    fprintf(fileID, 'Minimize \n');
    fprintf(fileID, 'WriteMagnetization %s/%s/%s \n', ...
        groundstatepath, subfolder, filename);
    
    
    % calculate energy
    fprintf(fileID, 'Set MaxMeshNumber 1 \n');
    fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', path, meshname);
    for i = 1:10
        rotangley = (b*(-i+5.5)/(N-1))*pi/180;
        fprintf(fileID, 'CubicRotation 0 %1.4f %1.4f SD = %d \n',rotangley+0.6154,-0.7854,i);
    end
    fprintf(fileID, 'Set MaxEnergyEvaluations 10000 \n');
    fprintf(fileID, 'Set MaxPathEvaluations 1000 \n');
    fprintf(fileID, 'ConjugateGradient \n');
    fprintf(fileID, 'Set ExchangeCalculator 1 \n');
    fprintf(fileID, 'magnetite %g C \n', T);
    fprintf(fileID, 'Set PathN 2 \n');
    fprintf(fileID, 'ReadMagnetization %s/%s_p/%s.dat \n', ...
        groundstatepath0, subfolder0, filename0);
    fprintf(fileID, 'MagnetizationToPath 1 \n');
    fprintf(fileID, 'ReadMagnetization %s/%s/%s.dat \n', ...
        groundstatepath, subfolder, filename);
    fprintf(fileID, 'MagnetizationToPath 2 \n');
    
    fprintf(fileID, 'EnergyLog %s/%s/%s \n', ...
        energylog_initial_path, subfolder, filename);
    fprintf(fileID, 'RefinePathTo 3 \n');
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
    fprintf(fileID, 'PathStructureEnergies %s/%s/%s.dat \n', ...
        energy_path, subfolder, filename);
    fprintf(fileID, 'End \n');
    fprintf(fileID, ' \n');
    fclose(fileID);
end