function BentCreateMagnetosomeGroundstateScript(x, y, z, d, N, b, crystal)

    meshpath = 'mesh_bent';
    groundstatepath = 'groundstates_bent';
    merrillpath = 'D:/magnetosomes_thermal';
    scriptpath = 'D:/magnetosomes_thermal/scripts/groundstates_bent';
    hysteresispath = 'hysteresis_groundstate_bent';
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

        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, groundstatepath), [subfolder '_p']); 
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, hysteresispath), [subfolder '_p']); 
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, groundstatepath), [subfolder '_n']); 
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, hysteresispath), [subfolder '_n']);
        
        fileID = fopen(sprintf('%s/%s.script', scriptpath, filename),'w');
        
        fprintf(fileID,'magnetite %g C \n', T(n));
        fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', meshpath, meshname);
        
        for i = 1:10
            rotangley = (b*(-i+5.5)/(N-1))*pi/180;
            fprintf(fileID, 'CubicRotation 0 %1.4f %1.4f SD = %d \n',rotangley+0.6154,-0.7854,i);
        end
        
        fprintf(fileID, 'Set MaxEnergyEvaluations 5000 \n');
        fprintf(fileID, 'external field direction 1 0 0 \n');
        fprintf(fileID, 'Uniform Magnetization 1 0 0 \n');
        fprintf(fileID, 'Randomize Magnetization 10 \n');
        fprintf(fileID, 'External field strength 0 mT  \n');
        fprintf(fileID, 'Minimize \n'); 
        fprintf(fileID, 'WriteMagnetization %s/%s_p/%s \n', ...
                groundstatepath, subfolder, filename); 
        fprintf(fileID, 'WriteHyst %s/%s_p/%s \n', ...
                hysteresispath, subfolder, filename); 

        fprintf(fileID, 'external field direction -1 0 0 \n');
        fprintf(fileID, 'Uniform Magnetization -1 0 0 \n'); 
        fprintf(fileID, 'Randomize Magnetization 10 \n'); 
        fprintf(fileID, 'External field strength 0 mT  \n'); 
        fprintf(fileID, 'Minimize \n'); 
        fprintf(fileID, 'WriteMagnetization %s/%s_n/%s \n', ...
                groundstatepath, subfolder, filename); 
        fprintf(fileID, 'WriteHyst %s/%s_n/%s \n', ...
                hysteresispath, subfolder, filename);  
            
        fprintf(fileID, '\n'); 

        fclose(fileID);
    end
end