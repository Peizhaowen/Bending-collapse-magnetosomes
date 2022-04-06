function BentCreateMagnetosomeEnergyBarrierRepeatSelectedRMBatch(modelname, Tname, selected_num, split_index)    
    filename = Tname;
    merrillpath = 'D:/magnetosomes_thermal'; 
    scriptpath = 'scripts/energy_barriers_bent'; 
    batchpath = 'batch_energy_barriers_bent_ReadZoneandMin'; 
    [~,~,~] = mkdir(merrillpath, batchpath);
    fileID = fopen(sprintf('%s/%s/%s.bat', ...
        merrillpath, batchpath, filename),'w');
    fprintf(fileID,'@cd .. \n');
    fprintf(fileID, '@IF EXIST "groundstates_bent/%s/Min_%s_%d_%d.dat" (\n', modelname, Tname, selected_num, split_index);
    fprintf(fileID, '@ECHO Min file already exists\n');
    fprintf(fileID, ') ELSE (\n');
    Scriptname = sprintf('ReadZone_%s_%d_%d', Tname,selected_num, split_index);
    fprintf(fileID,'merrill %s/%s.script \n', scriptpath, Scriptname);
    fprintf(fileID, ') \n');
    fclose(fileID);
end