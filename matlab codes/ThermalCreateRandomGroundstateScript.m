function ThermalCreateRandomGroundstateScript(x, y, z, d, N, b, crystal)
% ThermalCreateRandomGroundstateScript(40, 40, 40, 8, 10, 0, 'c')
    meshpath = 'mesh_bent';
    groundstatepath = 'groundstates_bent_random';
    merrillpath = 'D:/magnetosomes_thermal';
    scriptpath = 'D:/magnetosomes_thermal/scripts/groundstates_bent_random';
    hysteresispath = 'hysteresis_groundstate_bent_random';
    if crystal == 'c'
        subfolder = sprintf('%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
        meshname = sprintf('magnetosome_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    end

    if crystal == 'co'
        subfolder = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
        meshname = sprintf('magnetosome_Cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    end
    
    [~,~,~] = mkdir(scriptpath); 
    % T = [0:20:560 575]; 
    T = [20]; 

    for n = 1:length(T)
        filename = sprintf('%s_%gx_%gy_%gz_%gd_%dN_%db_%gT', crystal, x, y, z, d, N, b, T(n));
        
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, groundstatepath), [subfolder]);
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, hysteresispath));

        
        fileID = fopen(sprintf('%s/%s.script', scriptpath, filename),'w');
        for a = 1:100
            fprintf(fileID,'magnetite %g C \n', T(n));
            fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', meshpath, meshname);
            
            for i = 1:10
                rotangley = (b*(-i+5.5)/(N-1))*pi/180;
                fprintf(fileID, 'CubicRotation 0 %1.4f %1.4f SD = %d \n',rotangley+0.6154,-0.7854,i);
            end
            
            fprintf(fileID, 'Set MaxEnergyEvaluations 10000 \n');
            fprintf(fileID, 'Randomize all moments \n');
            fprintf(fileID, 'Minimize \n');
            fprintf(fileID, 'WriteMagnetization %s/%s/%s_%d \n', ...
                groundstatepath, subfolder, filename, a);
            fprintf(fileID, 'WriteHyst %s/%s \n', ...
                hysteresispath, filename);
            
            fprintf(fileID, '\n');
        end
        fclose(fileID);
    end
end