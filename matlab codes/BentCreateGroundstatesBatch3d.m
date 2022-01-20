function BentCreateGroundstatesBatch3d(x, y, z, d, N, b,r,crystal)
    merrillpath = 'D:/magnetosomes_thermal'; 
    scriptpath = 'scripts/groundstates_bent3d'; 
    batchpath = 'batch_groundstates_bent3d'; 
    
    [~,~,~] = mkdir(merrillpath, batchpath); 
    
    filename = sprintf('3d%s_%dx_%dy_%dz_%dd_%dN_%db_%dr', crystal, x, y, z, d, N, b,r);
    fileID = fopen(sprintf('%s/%s/%s.bat', ...
            merrillpath, batchpath, filename),'w');
	fprintf(fileID,'@cd .. \n');
	
    T = [0:20:560 575]; 
    
    for n = 1:length(T)
        fprintf(fileID, '@IF EXIST "hysteresis_groundstate_bent3d/%s_n/%s_%dT.hyst" (\n', filename, filename, T(n)); 
        fprintf(fileID, '@ECHO hysteresis loop already exists\n'); 
        fprintf(fileID, ') ELSE (\n'); 
        fprintf(fileID,'merrill %s/%s_%dT.script \n', scriptpath, filename, T(n));
        fprintf(fileID, ') \n'); 
    end
    fclose(fileID);
end