function ThermalNRMCreateAllScriptFiles3d(x, y, z, d, N, b)
% ThermalNRMCreateAllScriptFiles3d(40, 40, 40, 8, 10, 10)
    randpath = sprintf('D:/magnetosomes/randangle/randangle.csv');
    fid = fopen(randpath);
    Rand = textscan(fid, ' %f','delimiter',',');
    rand = Rand{1};
    fclose(fid);
    for r =1:10
         ThermalCreateRandomGroundstateScript3d(x, y, z, d, N, b, r, rand)
        ThermalCreateGroundstatesBatch3d(x, y, z, d, N, b, r);
    end
end