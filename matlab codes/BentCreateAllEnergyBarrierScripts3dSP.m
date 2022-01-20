function BentCreateAllEnergyBarrierScripts3dSP(x, y, z, d, N, b, crystal)

    randpath = sprintf('D:/magnetosomes/randangle/randangle.csv');
    fid = fopen(randpath);
    Rand = textscan(fid, ' %f','delimiter',',');
    rand = Rand{1};
    fclose(fid);
    for r =1:10
        BentCreateMagnetosomeEnergyBarrierScript3dSP(x, y, z, d, N, b,r,crystal,rand);
        BentCreateEnergyPathBatch3dSP(x, y, z, d, N, b, r, crystal);
    end
end