function NRMCreateMerrillBatch3d(x, y, z, d, N, r, scriptfiles)
    merrillpath = 'D:/magnetosomes_NRM'; 
    domainpath = 'D:/magnetosomes_NRM/scripts/NRM_bent3d';
    filename = sprintf('3d%dx_%dy_%dz_%dd_%dN_%dr', x, y, z, d, N, r);
    scriptpath = sprintf('%s/%s', domainpath, filename); 
    batchpath = 'batch_bent_NRM3d'; 
    
    [~,~,~] = mkdir(merrillpath, batchpath); 
    
    fileID = fopen(sprintf('%s/%s/%s.bat', merrillpath, batchpath, filename),'w');
    
    fprintf(fileID,'@cd .. \n');
    
    for a = 1:length(scriptfiles)
        fprintf(fileID,'merrill %s/%s.script \n', scriptpath, scriptfiles{a});
        fprintf(fileID, ' \n'); 
    end
    
    fclose(fileID);
end