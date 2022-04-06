function BentCreateMagnetosomeEnergyBarrierRepeatReadZoneandMin(modelname, meshname, Tname, T, b, selected_num, split_index)    
    path = 'mesh_bent';
    merrillpath = 'D:/magnetosomes_thermal';
    final_path = 'barrier_paths_final_bent'; 
    groundstatepath = 'groundstates_bent'; 
    scriptpath = 'D:/magnetosomes_thermal/scripts/energy_barriers_bent'; 
    N = 10;
    subfolder = modelname;
    
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, groundstatepath), subfolder); 
    filename0 = sprintf('%s_%d', ...
        Tname,selected_num);
    filename = sprintf('ReadZone_%s_%d_%d', ...
        Tname,selected_num, split_index);
    filenamemin = sprintf('Min_%s_%d_%d', ...
        Tname,selected_num, split_index);
    fileID = fopen(sprintf('%s/%s.script', scriptpath, filename),'w');
    
    % Readzone
    fprintf(fileID, 'magnetite %g C \n', T);
    fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', path, meshname);
    for i = 1:10
        rotangley = (b*(-i+5.5)/(N-1))*pi/180;
        fprintf(fileID, 'CubicRotation 0 %1.4f %1.4f SD = %d \n',rotangley+0.6154,-0.7854,i);
    end
    fprintf(fileID, 'ReadTecPlotZone %s/%s/%s %d\n', ...
        final_path, subfolder, filename0, split_index);
    
    fprintf(fileID, 'WriteMagnetization %s/%s/%s \n', ...
        groundstatepath, subfolder, filename);
    fprintf(fileID, '\n');
    
    % Min
    fprintf(fileID, 'magnetite %g C \n', T);
    fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', path, meshname);
            fprintf(fileID, 'Set MaxEnergyEvaluations 50000 \n');
    for i = 1:10
        rotangley = (b*(-i+5.5)/(N-1))*pi/180;
        fprintf(fileID, 'CubicRotation 0 %1.4f %1.4f SD = %d \n',rotangley+0.6154,-0.7854,i);
    end
    fprintf(fileID, 'ReadMagnetization %s/%s/%s.dat \n', ...
        groundstatepath, subfolder, filename); 
    fprintf(fileID, 'Randomize Magnetization 10 \n'); 
    fprintf(fileID, 'External field strength 0 mT  \n'); 
    fprintf(fileID, 'Minimize \n'); 
    fprintf(fileID, 'WriteMagnetization %s/%s/%s \n', ...
        groundstatepath, subfolder, filenamemin);
    
    fprintf(fileID, 'End \n');
    fclose(fileID);
    
end