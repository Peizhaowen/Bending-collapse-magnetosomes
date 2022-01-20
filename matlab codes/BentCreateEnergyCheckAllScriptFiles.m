function BentCreateEnergyCheckAllScriptFiles(x, y, z, d, N, b, crystal) 
    [theta, phi] = LoadRandomAngles();
        num = 100;
    scriptfiles = cell(num);
    for a = 1:num
        scriptfiles{a} =  BentCreateMagnetosomeEnergyCheckScript(x, y, z, d, N, b,a,crystal, theta(a), phi(a));
    end
    BentCreateEnergyCheckBatch(x, y, z, d, N, b, crystal,scriptfiles);
end