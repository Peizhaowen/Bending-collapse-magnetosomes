function BentCreateEnergyCheckBatch(x, y, z, d, N, b, crystal, scriptfiles)
    merrillpath = 'D:/magnetosomes_thermal'; 
    scriptpath = 'scripts/energy_barriers_bent_other'; 
    batchpath = 'batch_energy_barriers_bent_other'; 
    [~,~,~] = mkdir(merrillpath, batchpath); 
    
    filename = sprintf('%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    fileID = fopen(sprintf('%s/%s/%s.bat', ...
                merrillpath, batchpath, filename),'w');
    
    fprintf(fileID,'@cd .. \n');
    
    for a = 1:length(scriptfiles)
        T = 20;
        filename = sprintf('%s_%gx_%gy_%gz_%gd_%dN_%db_%gT_%da', crystal, x, y, z, d, N, b, T, a);
        if crystal == 'c'
            subfolder = sprintf('%gx_%gy_%gz_%gd_%dN_%db_%da', x, y, z, d, N, b, a);
        end
        if crystal == 'co'
            subfolder = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_%db_%da', x, y, z, d, N, b, a);
        end
        fprintf(fileID, '@IF EXIST "energy_bent_other/%s/%s.dat" (\n', subfolder, filename);
        fprintf(fileID, '@ECHO energy files already exists\n');
        fprintf(fileID, ') ELSE (\n'); 
        fprintf(fileID,'merrill %s/%s.script \n', scriptpath, scriptfiles{a});
        fprintf(fileID, ') \n'); 
    end
    
    fclose(fileID);
end