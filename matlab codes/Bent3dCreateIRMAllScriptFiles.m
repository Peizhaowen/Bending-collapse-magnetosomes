function Bent3dCreateIRMAllScriptFiles(x, y, z, d, N, b) 
    [theta, phi] = Load3dRandomAngles();
    scriptfiles = cell(100);
	merrillpath = 'D:/magnetosomes_3d';
	scriptpath = 'D:/magnetosomes_3d/scripts/IRM_bent3d';
	IRMpath = 'IRM_bent3d';
	[~,~,~] = mkdir(scriptpath);
	[~,~,~] = mkdir(merrillpath, IRMpath);
    for a = 1:10
        for r = 1:10
            id = a+10*(r-1)+100*(b/10-1);
            fileID = r+10*(a-1);
            scriptfiles{fileID} = Bent3dCreateIRMScript(x, y, z, d, N, b, r, a, theta(a), phi(a));
        end
    end
    Bent3dCreateIRMMerrillBatch(x, y, z, d, N, b, scriptfiles);
end