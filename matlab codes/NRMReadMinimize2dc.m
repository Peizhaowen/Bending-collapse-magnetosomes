function scriptfilename = NRMReadMinimize2dc(x,y,z,d,N,b)
    
    merrillpath = 'D:/magnetosomes_NRM';
    domainpath = 'D:/magnetosomes_NRM/scripts/NRM_bent';
    filename = sprintf('Cuboctahedron_%dx_%dy_%dz_%dd_%dN', x, y, z, d, N);
    meshpath = 'mesh_bent_NRM';
    NRMpath = 'NRM_bent';
    NRMdomainpath = 'domainstates_bent_NRM';
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, NRMdomainpath), filename);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, NRMpath));

    scriptfilename = sprintf('%s_%db',filename,b);
    fileID = fopen(sprintf('%s/%s/%s.script', domainpath, filename, scriptfilename),'w');
    fprintf(fileID,'magnetite 20 C \n');

    if b == 0
        meshname = sprintf('magnetosome_cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
        fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', meshpath, meshname);
        fprintf(fileID, 'external field direction 1 0 0\n');
        fprintf(fileID, 'ReadMagnetization scripts/NRM_bent/co_%dx_%dy_%dz_%dd_%dN_0b_20T.dat \n', x, y, z, d, N);
        fprintf(fileID, 'WriteMagnetization %s/%s/minimize_%s_0b_1a \n',NRMdomainpath, filename, filename);
        fprintf(fileID, 'WriteHyst %s/read_%s_1a \n', NRMpath, filename);
        fprintf(fileID, 'WriteHyst %s/minimize_%s_1a \n', NRMpath, filename);
    else
        meshname = sprintf('magnetosome_cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
        fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', meshpath, meshname);
        fprintf(fileID, 'external field direction 1 0 0\n');
        
        fprintf(fileID, 'ReadMagnetization scripts/NRM_bent/%s/%s_%db_0_mT_1a.dat\n',filename, filename, b);
        fprintf(fileID, 'WriteMagnetization %s/%s/read_%s_%db_1a\n',NRMdomainpath, filename, filename,b);
        fprintf(fileID, 'WriteHyst %s/read_%s_1a \n', NRMpath, filename);
        
        fprintf(fileID, 'Cubic Anisotropy \n');
        for i = 1:10
            rotangley = (b*(-i+5.5)/(N-1))*pi/180;
            fprintf(fileID, 'CubicRotation 0 %1.4f %1.4f SD = %d \n',rotangley+0.6154,-0.7854,i);
        end
        
        fprintf(fileID, 'External field strength 0 mT \n');
        fprintf(fileID, 'Minimize\n');
        fprintf(fileID, 'WriteMagnetization %s/%s/minimize_%s_%db_1a\n',NRMdomainpath, filename, filename,b);
        fprintf(fileID, 'WriteHyst %s/minimize_%s_1a \n', NRMpath, filename);
    end
    fclose(fileID);
end