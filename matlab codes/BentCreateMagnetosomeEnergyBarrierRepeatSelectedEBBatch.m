function BentCreateMagnetosomeEnergyBarrierRepeatSelectedEBBatch(modelname, Tname, selected_num, split_index)
    merrillpath = 'D:/magnetosomes_thermal';
    scriptpath = 'scripts/energy_barriers_bent';
    batchpath = 'batch_energy_barriers_bent_repeat';
    filename =  sprintf('%s_%d_%d', Tname, selected_num, split_index);
    fileID = fopen(sprintf('%s/%s/%s.bat', ...
        merrillpath, batchpath, filename),'w');
    fprintf(fileID,'@cd .. \n');
    for n = 1:2
        for num = 1:5
            scriptname =  sprintf('%s_%d_%d', filename, n, num);
            fprintf(fileID, '@IF EXIST "energy_bent/%s/%s.dat" (\n', modelname, scriptname);
            fprintf(fileID, '@ECHO split NEB already exists\n');
            fprintf(fileID, ') ELSE (\n');
            fprintf(fileID,'merrill %s/%s.script\n', scriptpath, scriptname);
            fprintf(fileID, ') \n');
        end
    end
    fclose(fileID);
end