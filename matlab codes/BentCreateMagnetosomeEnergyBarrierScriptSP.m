function BentCreateMagnetosomeEnergyBarrierScriptSP(x, y, z, d, N, b, crystal)
    path = 'mesh_bent'; 
    merrillpath = 'D:/magnetosomes_thermal'; 
    energy_path= 'energy_bent_SP'; 
    final_path = 'barrier_paths_final_bent'; 
    scriptpath = 'D:/magnetosomes_thermal/scripts/energy_barriers_bent_SP'; 
    
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
        filename = sprintf('%s_%gx_%gy_%gz_%gd_%dN_%db_%gT', crystal, x, y, z, d, N, b, T(n));
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, energy_path), subfolder);
        fileID = fopen(sprintf('%s/%s.script', scriptpath, filename),'w');
        
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
        fprintf(fileID, 'magnetite %g C \n', T(n));
        
        fprintf(fileID, 'ReadTecPlotPath %s/%s/%s \n', ...
            final_path, subfolder, filename);
        fprintf(fileID, 'PathStructureAllComponents %s/%s/%s.dat \n', ...
            energy_path, subfolder, filename);
        fprintf(fileID, 'End \n');
        fprintf(fileID, ' \n');  
        fclose(fileID);
    end
end