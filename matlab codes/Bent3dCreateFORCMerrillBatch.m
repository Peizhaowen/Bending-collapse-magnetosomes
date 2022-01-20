function Bent3dCreateFORCMerrillBatch(x, y, z, d, N, b, r, scriptfiles)
    merrillpath = 'D:/magnetosomes'; 
    scriptpath = 'scripts/hysteresis_bent3d_single_FORC'; 
    batchpath = 'batch_bent3d_FORC'; 
    
    [~,~,~] = mkdir(merrillpath, batchpath); 
   
    filename = sprintf('3d_FORC_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b, r);
    fileID = fopen(sprintf('%s/%s/%s_2.5.bat', ...
        merrillpath, batchpath, filename),'w');
    
    fprintf(fileID,'@cd .. \n');
    
    for a = 1:length(scriptfiles)
        fprintf(fileID, '@IF EXIST "hysteresis_bent3d_single_FORC/%s_hyst_2.5.hyst" (\n', scriptfiles{a});
        fprintf(fileID, '@ECHO hysteresis loop already exists\n');
        fprintf(fileID, ') ELSE (\n');
        fprintf(fileID,'merrill %s/%s.script \n', scriptpath, scriptfiles{a});
        fprintf(fileID, ') \n');
    end
    fclose(fileID);
end
