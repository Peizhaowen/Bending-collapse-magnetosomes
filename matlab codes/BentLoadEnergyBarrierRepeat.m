function E = BentLoadEnergyBarrierRepeat(modelname, Tname, type)
    energy_path = sprintf('D:/magnetosomes_thermal/%s', type);
    subfolder = modelname;
    filename = sprintf('%s.dat', Tname);
    full_path = fullfile(energy_path, subfolder, filename);
    
    fid = fopen(full_path, 'r');
    if fid ~= -1
        C = textscan(fid, '%f %f');
        fclose(fid);
        E = C{2};
        index = C{1};
    else
        E = [];
    end
end