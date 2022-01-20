function BentCuboctahedronCreateIRMMerrillBatch(x, y, z, d, N, b, scriptfiles)

    merrillpath = 'D:/magnetosomes'; 
    scriptpath = 'scripts/IRM_bent_cuboctahedron'; 
    batchpath = 'batch_bent_IRM_cuboctahedron'; 

        [~,~,~] = mkdir(merrillpath, batchpath); 

    filename = sprintf('IRM_cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    fileID = fopen(sprintf('%s/%s/%s.bat', ...
                merrillpath, batchpath, filename),'w');
    fprintf(fileID,'@cd .. \n');
    
    for a = 1:length(scriptfiles)
        fprintf(fileID, '@IF EXIST "IRM_bent_cuboctahedron/%s.hyst" (\n', scriptfiles{a}); 
        fprintf(fileID, '@ECHO hysteresis loop already exists\n'); 
        fprintf(fileID, ') ELSE (\n'); 
        fprintf(fileID,'merrill %s/%s.script \n', scriptpath, scriptfiles{a});
        fprintf(fileID, ') \n'); 
    end
    fclose(fileID);