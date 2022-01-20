function scriptfilename = ThermalNRMReadMinimizeSingleInAChain2d(x,y,z,d,N,b,crystal)
% ThermalNRMReadMinimizeSingleInAChain2d(40,40,40,3,10,0,'c')

merrillpath = 'D:/magnetosomes_thermal';
spath = 'D:/magnetosomes_thermal/scripts/NRM_bent';
meshpath = 'mesh_bent';
NRMdomainpath = 'groundstates_bent';
    if crystal == 'c'
        subfolder = sprintf('%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
        meshname = sprintf('magnetosome_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    end

    if crystal == 'co'
        subfolder = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
        meshname = sprintf('magnetosome_Cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    end
[~,~,~] = mkdir(sprintf('%s/%s', merrillpath, NRMdomainpath), [subfolder '_p']);
[~,~,~] = mkdir(sprintf('%s/%s', merrillpath, NRMdomainpath), [subfolder '_n']);
[~,~,~] = mkdir(sprintf('%s', spath));
T = [0:20:560 575];
for di = 1:2
    if di == 1
        direction = 'p';
    end
    if di == 2
        direction = 'n';
    end
    for n = 1:length(T)
        filename = sprintf('%s_%gx_%gy_%gz_%gd_%dN_%db_%gT_single', crystal, x, y, z, d, N, b, T(n));
        scriptfilename = sprintf('%s_%s',filename,direction);
        fileID = fopen(sprintf('%s/%s.script', spath, scriptfilename),'w');
        fprintf(fileID,'magnetite %g C \n', T(n));
        
        if b == 0
            fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', meshpath, meshname);
            fprintf(fileID, 'ReadMagnetization groundstates_bent_read/%s_%s/%s.dat \n', subfolder, direction, filename);
            fprintf(fileID, 'WriteMagnetization %s/%s_%s/%s \n',NRMdomainpath, subfolder, direction, filename);
        else
            fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', meshpath, meshname);
            if di == 1
                fprintf(fileID, 'external field direction 1 0 0 \n');
            end
            if di == 2
                fprintf(fileID, 'external field direction 1 0 0\n');
            end
            fprintf(fileID, 'ReadMagnetization groundstates_bent_read/%s_%s/%s.dat \n', subfolder, direction, filename);
            fprintf(fileID, 'Cubic Anisotropy \n');
            for i = 1:10
                rotangley = (b*(-i+5.5)/(N-1))*pi/180;
                fprintf(fileID, 'CubicRotation 0 %1.4f %1.4f SD = %d \n',rotangley+0.6154,-0.7854,i);
            end
            
            fprintf(fileID, 'External field strength 0 mT \n');
            fprintf(fileID, 'Minimize\n');
            fprintf(fileID, 'WriteMagnetization %s/%s_%s/%s \n',NRMdomainpath, subfolder, direction, filename);
        end
        fclose(fileID);
    end
end
end