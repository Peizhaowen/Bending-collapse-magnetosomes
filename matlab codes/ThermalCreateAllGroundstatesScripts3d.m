function ThermalCreateAllGroundstatesScripts3d(x, y, z, d, N, b)
    randpath = sprintf('D:/magnetosomes/randangle/randangle.csv');
    fid = fopen(randpath);
    Rand = textscan(fid, ' %f','delimiter',',');
    rand = Rand{1};
    fclose(fid);
    for r =1:10
        ThermalCreateRandomGroundstateScript(x,y,z,d,N,b,r,rand)
        ThermalCreateGroundstatesBatch3d(x, y, z, d, N, b, r)
    end
end