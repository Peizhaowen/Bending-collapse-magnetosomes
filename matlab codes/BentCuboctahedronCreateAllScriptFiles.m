function BentCuboctahedronCreateAllScriptFiles(x, y, z, d, N, b) 
    % BentCuboctahedronCreateAllScriptFiles(40, 40, 40, 8, 10, 0)
    [theta, phi] = LoadRandomAngles();
    if x == 100
        num =25;
    else
        num = 100;
    end
    scriptfiles = cell(num);
    for a = 1:num
        scriptfiles{a} = BentCuboctahedronCreateMagnetosomeHysteresisScript(x, y, z, d, N, b,a, theta(a), phi(a));
    end
    BentCuboctahedronCreateMerrillBatch(x, y, z, d, N, b,scriptfiles);
end