function ThermalCreateGroundstatesBatch(x, y, z, d, N, b,crystal)
% ThermalCreateGroundstatesBatch(40, 40, 40, 8, 10, 0, 'c')
    merrillpath = 'D:/magnetosomes_thermal'; 
    scriptpath = 'scripts/groundstates_bent_random'; 
    batchpath = 'batch_groundstates_bent_random'; 
    
    [~,~,~] = mkdir(merrillpath, batchpath); 
    
	filename = sprintf('%s_%dx_%dy_%dz_%dd_%dN_%db', crystal, x, y, z, d, N, b);
    fileID = fopen(sprintf('%s/%s/%s.bat', ...
            merrillpath, batchpath, filename),'w');
	fprintf(fileID,'@cd .. \n');
	
    % T = [0:20:560 575]; 
    T = [20];
    for n = 1:length(T)
        fprintf(fileID, '@IF EXIST "hysteresis_groundstate_bent_random/%s_%dT.hyst" (\n', filename, T(n)); 
        fprintf(fileID, '@ECHO hysteresis loop already exists\n'); 
        fprintf(fileID, ') ELSE (\n'); 
        fprintf(fileID,'merrill %s/%s_%dT.script \n', scriptpath, filename, T(n));
        fprintf(fileID, ') \n'); 
    end
    fclose(fileID);
end