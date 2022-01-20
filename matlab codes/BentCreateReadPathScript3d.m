function BentCreateReadPathScript3d(x, y, z, d, N, b, r, crystal)
% BentCreateReadPathScript3d(40, 40, 40, 8, 10, 70, 1, 'co')
    meshpath = 'mesh_bent3d';
    pathstates = 'pathstates_bent3d';
    merrillpath = 'D:/magnetosomes_thermal';
    scriptpath = 'D:/magnetosomes_thermal/scripts/pathstates_bent3d';
    tecpath = 'barrier_paths_final_bent3d';
    subfolder = sprintf('3dco_%gx_%gy_%gz_%gd_%dN_%db_%dr', x, y, z, d, N, b, r);
    meshname = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b, r);
    [~,~,~] = mkdir(scriptpath);
    T = 20;
    filename = sprintf('3d%s_%gx_%gy_%gz_%gd_%dN_%db_%dr_%gT', crystal, x, y, z, d, N, b, r, T);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, pathstates), [subfolder]);
    fileID = fopen(sprintf('%s/%s.script', scriptpath, filename),'w');
    fprintf(fileID,'magnetite %g C \n', T);
    fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', meshpath, meshname);
    for i = 1:50
        fprintf(fileID, 'ReadTecPlotZone %s/%s/%s %d\n', tecpath, subfolder, filename, i);
        fprintf(fileID, 'WriteMagnetization %s/%s/%s_%dpath\n', pathstates, subfolder, filename, i);
    end
    fprintf(fileID, '\n');
    fclose(fileID);
end