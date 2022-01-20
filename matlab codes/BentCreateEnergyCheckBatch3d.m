function BentCreateEnergyCheckBatch3d(x, y, z, d, N, b, crystal, scriptfiles)
    merrillpath = 'D:/magnetosomes_thermal'; 
    scriptpath = 'scripts/energy_barriers_bent_other3d'; 
    batchpath = 'batch_energy_barriers_bent_other3d'; 
    [~,~,~] = mkdir(merrillpath, batchpath); 
    filename = sprintf('3d%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    fileID = fopen(sprintf('%s/%s/%s.bat', ...
                merrillpath, batchpath, filename),'w');
    fprintf(fileID,'@cd .. \n');
    
    for a = 1:length(scriptfiles)
        T = 20;
        fprintf(fileID,'merrill %s/%s.script \n', scriptpath, scriptfiles{a});
    end
    fclose(fileID);
end