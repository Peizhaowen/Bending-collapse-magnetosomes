function ThermalNRMCreateMerrillBatch3d(x, y, z, d, N, b,r,crystal)
    merrillpath = 'D:/magnetosomes_thermal'; 
    scriptpath = 'scripts/NRM_bent3d'; 
    batchpath = 'batch_groundstates_bent'; 
    [~,~,~] = mkdir(merrillpath, batchpath); 
	filename = sprintf('3d%s_%dx_%dy_%dz_%dd_%dN_%db_%dr', crystal, x, y, z, d, N, b,r);
    fileID = fopen(sprintf('%s/%s/%s.bat', ...
            merrillpath, batchpath, filename),'w');
	fprintf(fileID,'@cd .. \n');
    T = [0:20:560 575]; 

    for n = 1:length(T)
        fprintf(fileID, '@IF EXIST "groundstates_bent3d/%s_n/%s_%dT.dat" (\n', filename, filename, T(n)); 
        fprintf(fileID, '@ECHO dat already exists\n'); 
        fprintf(fileID, ') ELSE (\n'); 
        fprintf(fileID,'merrill %s/%s_%dT_n.script \n', scriptpath, filename, T(n));
        fprintf(fileID,'merrill %s/%s_%dT_p.script \n', scriptpath, filename, T(n));
        fprintf(fileID, ') \n'); 
    end
    fclose(fileID);
end