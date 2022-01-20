function scriptfilename = NRMReadMinimize3d(x,y,z,d,N,r,b)

    merrillpath = 'D:/magnetosomes_NRM';
    domainpath = 'D:/magnetosomes_NRM/scripts/NRM_bent3d';
    filename = sprintf('3d%dx_%dy_%dz_%dd_%dN_%dr', x, y, z, d, N, r);
    meshpath = 'mesh_bent3d_NRM';
    meshpath0 = 'mesh_bent_NRM';
    NRMpath = 'NRM_bent3d';
    NRMdomainpath = 'domainstates_bent3d_NRM';
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, NRMdomainpath), filename);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, NRMpath));
 
    scriptfilename = sprintf('%s_%db',filename,b);
    fileID = fopen(sprintf('%s/%s/%s.script', domainpath, filename, scriptfilename),'w');
    fprintf(fileID,'magnetite 20 C \n');
    
    if b == 0
        meshname = sprintf('magnetosome_cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
        fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', meshpath0, meshname);
        fprintf(fileID, 'external field direction 1 0 0\n');
        fprintf(fileID, 'ReadMagnetization scripts/NRM_bent3d/co_%dx_%dy_%dz_%dd_%dN_0b_20T.dat \n', x, y, z, d, N);
        fprintf(fileID, 'WriteMagnetization %s/%s/minimize_%s_0b_1a \n',NRMdomainpath, filename, filename);
        fprintf(fileID, 'WriteHyst %s/read_%s_1a \n', NRMpath, filename);
        fprintf(fileID, 'WriteHyst %s/minimize_%s_1a \n', NRMpath, filename);
    else
        meshname = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b, r);
        fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', meshpath, meshname);
        fprintf(fileID, 'external field direction 1 0 0\n');
        
        fprintf(fileID, 'ReadMagnetization scripts/NRM_bent3d/%s/%s_%db_0_mT_1a.dat\n',filename, filename, b);
        fprintf(fileID, 'WriteMagnetization %s/%s/read_%s_%db_1a\n',NRMdomainpath, filename, filename,b);
        fprintf(fileID, 'WriteHyst %s/read_%s_1a \n', NRMpath, filename);
        
        randpath = sprintf('D:/magnetosomes/randangle/randangle.csv');
        fid = fopen(randpath);
        Rand = textscan(fid, ' %f','delimiter',',');
        rand = Rand{1};
        
        for i = 1:N-1
            Rrot =Bent3dGetAnisaxis(x,y,z,d,N,b,r,i,rand);
            fprintf(fileID, 'CubicAxes %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f SD = %d \n',...
                Rrot(1,1),Rrot(1,2),Rrot(1,3),Rrot(2,1),Rrot(2,2),Rrot(2,3),Rrot(3,1),Rrot(3,2),Rrot(3,3), i);
        end
        fprintf(fileID,'CubicRotation 0 0.6154 -0.7854 SD = 10 \n');
        
        fprintf(fileID, 'External field strength 0 mT \n');
        fprintf(fileID, 'Minimize\n');
        fprintf(fileID, 'WriteMagnetization %s/%s/minimize_%s_%db_1a\n',NRMdomainpath, filename, filename,b);
        fprintf(fileID, 'WriteHyst %s/minimize_%s_1a \n', NRMpath, filename);
    end
    fclose(fileID);
end