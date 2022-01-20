function BentCreateEnergyCheckAllScriptFiles3d(x, y, z, d, N, b, crystal)
    [theta, phi] = Load3dRandomAngles();
    scriptfiles = cell(100);
    for a = 1:10
        for r = 1:10
            id = a+10*(r-1)+100*(b/10-1);
            fileID = r+10*(a-1);
            scriptfiles{fileID} =  BentCreateMagnetosomeEnergyCheckScript3d(x, y, z, d, N, b, r, a,crystal, theta(id), phi(id));
        end
    end
    BentCreateEnergyCheckBatch3d(x, y, z, d, N, b, crystal,scriptfiles);
end