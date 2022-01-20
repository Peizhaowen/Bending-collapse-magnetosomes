function BentCreateEnergyPathBatchSP(x, y, z, d, N, b,crystal)
    merrillpath = 'D:/magnetosomes_thermal'; 
    scriptpath = 'scripts/energy_barriers_bent_SP'; 
    batchpath = 'batch_energy_barriers_bent_SP'; 
    
    [~,~,~] = mkdir(merrillpath, batchpath); 
        
    T = [0:20:560 575]; 
    filename = sprintf('%s_%dx_%dy_%dz_%dd_%dN_%db', crystal, x, y, z, d, N, b);
    fileID = fopen(sprintf('%s/%s/%s.bat', ...
                merrillpath, batchpath, filename),'w');
	fprintf(fileID,'@cd .. \n');
    
    if crystal == 'c'
        subfolder = sprintf('%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
    end
    
    if crystal == 'co'
        subfolder = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
    end
    
    for n = 1:length(T)
		fprintf(fileID, '@IF EXIST "energy_bent_SP/%s/%s_%dT.dat" (\n', subfolder, filename, T(n)); 
        fprintf(fileID, '@ECHO energy already exists\n'); 
        fprintf(fileID, ') ELSE (\n'); 
        fprintf(fileID,'merrill %s/%s_%dT.script \n', scriptpath, filename, T(n));
        fprintf(fileID, ') \n'); 
    end
    fclose(fileID);    
end