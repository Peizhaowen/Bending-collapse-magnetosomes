function BentCuboctahedronCreateNRMAllScriptFiles(x, y, z, d, N) 
    [theta, phi] = LoadRandomAngles();
    scriptfiles = cell(1);
	merrillpath = 'D:/magnetosomes';
	scriptpath = 'D:/magnetosomes/scripts/NRM_bent';
	NRMpath = 'NRM_bent';
	[~,~,~] = mkdir(scriptpath);
	[~,~,~] = mkdir(merrillpath, NRMpath);
	scriptfiles{1} = BentCuboctahedronCreateNRMScript(x, y, z, d, N ,1, theta(1), phi(1));
end