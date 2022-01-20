function BentCreateReadPathScript(x, y, z, d, N, b, crystal)
% BentCreateReadPathScript(40, 40, 40, 8, 10, 0, 'co')
    meshpath = 'mesh_bent';
    pathstates = 'pathstates_bent';
    merrillpath = 'D:/magnetosomes_thermal';
    scriptpath = 'D:/magnetosomes_thermal/scripts/pathstates_bent';
    tecpath = 'barrier_paths_final_bent';
    if crystal == 'c'
        subfolder = sprintf('%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
        meshname = sprintf('magnetosome_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    end
    if crystal == 'co'
        subfolder = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
        meshname = sprintf('magnetosome_Cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    end
    [~,~,~] = mkdir(scriptpath);
    T = 20;
    filename = sprintf('%s_%gx_%gy_%gz_%gd_%dN_%db_%gT', crystal, x, y, z, d, N, b, T);
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