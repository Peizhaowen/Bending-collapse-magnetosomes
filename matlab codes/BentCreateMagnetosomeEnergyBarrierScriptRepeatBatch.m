function BentCreateMagnetosomeEnergyBarrierScriptRepeatBatch(x, y, z, d, N, b,crystal, T)
    merrillpath = 'D:/magnetosomes_thermal'; 
    scriptpath = 'scripts/energy_barriers_bent'; 
    batchpath = 'batch_energy_barriers_bent_repeat'; 
    
    [~,~,~] = mkdir(merrillpath, batchpath); 
    filename = sprintf('%s_%dx_%dy_%dz_%dd_%dN_%db_%dT', crystal, x, y, z, d, N, b, T);
    fileID = fopen(sprintf('%s/%s/%s.bat', ...
                merrillpath, batchpath, filename),'w');
	fprintf(fileID,'@cd .. \n');
    
    if crystal == 'c'
        subfolder = sprintf('%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
    end
    
    if crystal == 'co'
        subfolder = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
    end
    
    for n = 1:5
		fprintf(fileID, '@IF EXIST "energy_bent/%s/%s_%d.dat" (\n', subfolder, filename, n); 
        fprintf(fileID, '@ECHO hysteresis loop already exists\n'); 
        fprintf(fileID, ') ELSE (\n'); 
        fprintf(fileID,'merrill %s/%s_%d.script \n', scriptpath, filename, n);
        fprintf(fileID, ') \n'); 
    end
    fclose(fileID);    
end