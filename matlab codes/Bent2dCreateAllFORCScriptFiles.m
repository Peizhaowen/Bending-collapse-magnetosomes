function Bent2dCreateAllFORCScriptFiles(x, y, z, d, N, b) 
    % Bent2dCreateAllFORCScriptFiles(40, 40, 40, 8, 10, 0)
    [theta, phi] = LoadRandomAngles();
    scriptfiles = cell(100);
    for a = 1:100
        scriptfiles{a} = Bent2dCreateFORCSingleMagnetosomeScripts(x, y, z, d, N, b, a, theta(a), phi(a));
    end
    Bent2dCreateFORCMerrillBatch(x, y, z, d, N, b, scriptfiles);
end