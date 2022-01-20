function NRMCreateMerrillBatch2d(x, y, z, d, N, scriptfiles)
    merrillpath = 'D:/magnetosomes_NRM'; 
    domainpath = 'D:/magnetosomes_NRM/scripts/NRM_bent';
    filename = sprintf('%dx_%dy_%dz_%dd_%dN', x, y, z, d, N);
    scriptpath = sprintf('%s/%s', domainpath, filename); 
    batchpath = 'batch_bent_NRM'; 
    
    [~,~,~] = mkdir(merrillpath, batchpath); 
    
    fileID = fopen(sprintf('%s/%s/%s.bat', merrillpath, batchpath, filename),'w');
    
    fprintf(fileID,'@cd .. \n');
    
    for a = 1:length(scriptfiles)
        fprintf(fileID,'merrill %s/%s.script \n', scriptpath, scriptfiles{a});
        fprintf(fileID, ' \n'); 
    end
    
    fclose(fileID);
end