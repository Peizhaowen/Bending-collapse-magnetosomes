function Bent3dCreateNRMAllScriptFiles(x, y, z, d, N) 
	merrillpath = 'D:/magnetosomes';
	scriptpath = 'D:/magnetosomes/scripts/NRM_bent3d';
	NRMpath = 'NRM_bent_3d';
	[~,~,~] = mkdir(scriptpath);
	[~,~,~] = mkdir(merrillpath, NRMpath);
    % r = [2,3,6];
    for i = 1:10
        Bent3dCreateNRMScript(x, y, z, d, N, i);
    end
end