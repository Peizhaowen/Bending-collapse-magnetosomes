function Bent3dCreateAllScriptFiles(x, y, z, d, N, b) 
    [theta, phi] = Load3dRandomAngles();
    scriptfiles = cell(100);
	merrillpath = 'D:/magnetosomes_3d';
	scriptpath = 'D:/magnetosomes_3d/scripts/hysteresis_bent3d';
	hysteresispath = 'hysteresis_bent3d';
	[~,~,~] = mkdir(scriptpath);
	[~,~,~] = mkdir(merrillpath, hysteresispath);
    for a = 1:10
        for r = 1:10
            id = a+10*(r-1)+100*(b/10-1);
            fileID = r+10*(a-1);
            scriptfiles{fileID} = Bent3dCreateMagnetosomeHysteresisScript(x, y, z, d, N, b, r, a, theta(id), phi(id));
        end
    end
    Bent3dCreateMerrillBatch(x, y, z, d, N, b, scriptfiles);
end