function BentCreateMerrillBatch(x, y, z, d, N, b, scriptfiles)
    merrillpath = 'D:/magnetosomes'; 
    scriptpath = 'scripts/hysteresis_bent'; 
    batchpath = 'batch_bent'; 
    
    [~,~,~] = mkdir(merrillpath, batchpath); 
    
    filename = sprintf('%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    fileID = fopen(sprintf('%s/%s/%s.bat', ...
                merrillpath, batchpath, filename),'w');
    
    fprintf(fileID,'@cd .. \n');
    
    for a = 1:length(scriptfiles)
        fprintf(fileID, '@IF EXIST "hysteresis_bent/%s.hyst" (\n', scriptfiles{a}); 
        fprintf(fileID, '@ECHO hysteresis loop already exists\n'); 
        fprintf(fileID, ') ELSE (\n'); 
        fprintf(fileID,'merrill %s/%s.script \n', scriptpath, scriptfiles{a});
        fprintf(fileID, ') \n'); 
    end
    
    fclose(fileID);
end