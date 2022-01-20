function Bent3dCreateAllFORCScriptFiles(x, y, z, d, N, b, r) 
    [theta, phi] = Load3dRandomAngles();
    scriptfiles = cell(20);
    for a = 1:20
        id = a+20*(r-1);
        scriptfiles{a} = Bent3dCreateFORCSingleMagnetosomeScripts(x, y, z, d, N, b, r, a, theta(id), phi(id));
    end
    Bent3dCreateFORCMerrillBatch(x, y, z, d, N, b, r, scriptfiles);
end