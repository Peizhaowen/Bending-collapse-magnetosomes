function ThermalCreateGroundstatesBatch3d(x, y, z, d, N, b, r)
    merrillpath = 'D:/magnetosomes_thermal'; 
    scriptpath = 'scripts/groundstates_bent_random3d'; 
    batchpath = 'batch_groundstates_bent_random3d'; 
    
    [~,~,~] = mkdir(merrillpath, batchpath); 
    
	filename = sprintf('3dco_%gx_%gy_%gz_%gd_%dN_%db_%dr', x, y, z, d, N, b, r);
    fileID = fopen(sprintf('%s/%s/%s.bat', ...
            merrillpath, batchpath, filename),'w');
	fprintf(fileID,'@cd .. \n');
	
    % T = [0:20:560 575]; 
    T = [20];
    for n = 1:length(T)
        fprintf(fileID, '@IF EXIST "hysteresis_groundstate_bent_random3d/%s_%dT.hyst" (\n', filename, T(n)); 
        fprintf(fileID, '@ECHO hysteresis loop already exists\n'); 
        fprintf(fileID, ') ELSE (\n'); 
        fprintf(fileID,'merrill %s/%s_%dT.script \n', scriptpath, filename, T(n));
        fprintf(fileID, ') \n'); 
    end
    fclose(fileID);
end