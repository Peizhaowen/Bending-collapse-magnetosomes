function scriptfilename = ThermalNRMReadMinimize3d(x,y,z,d,N,b,r,rand)
% ThermalNRMReadMinimize3d(40,40,40,8,10,1,50)

merrillpath = 'D:/magnetosomes_thermal';
spath = 'D:/magnetosomes_thermal/scripts/NRM_bent3d';
meshpath = 'mesh_bent3d';
NRMdomainpath = 'groundstates_bent3d';
subfolder = sprintf('3dco_%gx_%gy_%gz_%gd_%dN_%db_%dr', x, y, z, d, N, b, r);
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
        filename = sprintf('3dco_%gx_%gy_%gz_%gd_%dN_%db_%dr_%gT', x, y, z, d, N, b, r, T(n));
        
        scriptfilename = sprintf('%s_%s',filename,direction);
        fileID = fopen(sprintf('%s/%s.script', spath, scriptfilename),'w');
        fprintf(fileID,'magnetite %g C \n', T(n));
        meshname = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b, r);
        fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', meshpath, meshname);
        if di == 1
            fprintf(fileID, 'external field direction 1 0 0 \n');
        end
        if di == 2
            fprintf(fileID, 'external field direction 1 0 0\n');
        end
        fprintf(fileID, 'ReadMagnetization groundstates_bent_read3d/%s_%s/%s.dat \n', subfolder, direction, filename);
        for i = 1:N-1
            Rrot =Bent3dGetAnisaxis(x,y,z,d,N,b,r,i,rand);
            fprintf(fileID, 'CubicAxes %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f SD = %d \n',...
                Rrot(1,1),Rrot(1,2),Rrot(1,3),Rrot(2,1),Rrot(2,2),Rrot(2,3),Rrot(3,1),Rrot(3,2),Rrot(3,3), i);
        end
        fprintf(fileID,'CubicRotation 0 0.6154 -0.7854 SD = 10 \n');
        
        fprintf(fileID, 'External field strength 0 mT \n');
        fprintf(fileID, 'Minimize\n');
        fprintf(fileID, 'WriteMagnetization %s/%s_%s/%s \n',NRMdomainpath, subfolder, direction, filename);
        fclose(fileID);
    end
end
end