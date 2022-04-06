function BentCreateMagnetosomeEnergyBarrierScript3dRepeatBatch(x, y, z, d, N, b,r, crystal, T)

    merrillpath = 'D:/magnetosomes_thermal'; 
    scriptpath = 'scripts/energy_barriers_bent3d'; 
    batchpath = 'batch_energy_barriers_bent_repeat3d'; 
    
    [~,~,~] = mkdir(merrillpath, batchpath); 
    filename = sprintf('3d%s_%dx_%dy_%dz_%dd_%dN_%db_%dr_%dT', crystal, x, y, z, d, N, b,r,T);
    fileID = fopen(sprintf('%s/%s/%s.bat', ...
                merrillpath, batchpath, filename),'w');
	fprintf(fileID,'@cd .. \n');
    subfolder = sprintf('3d%s_%dx_%dy_%dz_%dd_%dN_%db_%dr', crystal, x, y, z, d, N, b,r);
    
    for n = 1:5
		fprintf(fileID, '@IF EXIST "energy_bent3d/%s/%s_%d.dat" (\n', subfolder, filename, n); 
        fprintf(fileID, '@ECHO hysteresis loop already exists\n'); 
        fprintf(fileID, ') ELSE (\n'); 
        fprintf(fileID,'merrill %s/%s_%d.script \n', scriptpath, filename, n);
        fprintf(fileID, ') \n'); 
    end
    fclose(fileID);    

end