function ThermalNRMCreateMerrillBatch2d(x, y, z, d, N, b, crystal)
    merrillpath = 'D:/magnetosomes_thermal'; 
    scriptpath = 'scripts/NRM_bent'; 
    batchpath = 'batch_groundstates_bent'; 
    [~,~,~] = mkdir(merrillpath, batchpath); 
	filename = sprintf('%s_%dx_%dy_%dz_%dd_%dN_%db', crystal, x, y, z, d, N, b);
    fileID = fopen(sprintf('%s/%s/%s.bat', ...
            merrillpath, batchpath, filename),'w');
	fprintf(fileID,'@cd .. \n');
    T = [0:20:560 575]; 
    if crystal == 'c'
        subfolder = sprintf('%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
    end
    if crystal == 'co'
        subfolder = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
    end
    for n = 1:length(T)
        fprintf(fileID, '@IF EXIST "groundstates_bent/%s_n/%s_%dT.dat" (\n', subfolder, filename, T(n)); 
        fprintf(fileID, '@ECHO dat already exists\n'); 
        fprintf(fileID, ') ELSE (\n'); 
        fprintf(fileID,'merrill %s/%s_%dT_n.script \n', scriptpath, filename, T(n));
        fprintf(fileID,'merrill %s/%s_%dT_p.script \n', scriptpath, filename, T(n));
        fprintf(fileID, ') \n'); 
    end
    fclose(fileID);
end