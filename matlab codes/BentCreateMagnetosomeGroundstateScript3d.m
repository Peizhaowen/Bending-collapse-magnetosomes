function BentCreateMagnetosomeGroundstateScript3d(x, y, z, d, N, b, r, crystal,rand)

    meshpath = 'mesh_bent3d';
    groundstatepath = 'groundstates_bent3d';
    merrillpath = 'D:/magnetosomes_thermal';
    scriptpath = 'D:/magnetosomes_thermal/scripts/groundstates_bent3d';
    hysteresispath = 'hysteresis_groundstate_bent3d';
    subfolder = sprintf('3d%gx_%gy_%gz_%gd_%dN_%db_%dr', x, y, z, d, N, b, r);
    meshname = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b, r);

    
    [~,~,~] = mkdir(scriptpath); 
    T = [0:20:560 575]; 
    
    for n = 1:length(T)
        filename = sprintf('3d%s_%gx_%gy_%gz_%gd_%dN_%db_%dr_%gT', crystal, x, y, z, d, N, b, r, T(n));

        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, groundstatepath), [subfolder '_p']); 
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, hysteresispath), [subfolder '_p']); 
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, groundstatepath), [subfolder '_n']); 
        [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, hysteresispath), [subfolder '_n']); 

        fileID = fopen(sprintf('%s/%s.script', scriptpath, filename),'w');

        fprintf(fileID,'magnetite %g C \n', T(n));
        fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', meshpath, meshname);
        
        for i = 1:N-1
            Rrot =Bent3dGetAnisaxis(x,y,z,d,N,b,r,i,rand);
            fprintf(fileID, 'CubicAxes %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f SD = %d \n',...
                Rrot(1,1),Rrot(1,2),Rrot(1,3),Rrot(2,1),Rrot(2,2),Rrot(2,3),Rrot(3,1),Rrot(3,2),Rrot(3,3), i);
        end
        fprintf(fileID,'CubicRotation 0 0.6154 -0.7854 SD = 10 \n');
         
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