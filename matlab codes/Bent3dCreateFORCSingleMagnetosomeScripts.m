function filename=Bent3dCreateFORCSingleMagnetosomeScripts(x,y,z,d,N,b,r,a,theta,phi)
    %Bent3dCreateFORCMagnetosomeScripts(40,40,40,8,10,30)
    path = 'mesh_bent3d';
    domainpath = 'domainstates_bent3d_single_FORC';
    merrillpath = 'D:/magnetosomes';
    scriptpath = 'D:/magnetosomes/scripts/hysteresis_bent3d_single_FORC';
    hystpath = 'hysteresis_bent3d_single_FORC';
    filename = sprintf('3d_FORC_%dx_%dy_%dz_%dd_%dN_%db_%dr_%da', x, y, z, d, N, b, r, a);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, domainpath), filename);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, hystpath));
    [~,~,~] = mkdir(sprintf('%s',scriptpath));

        
    fileID = fopen(sprintf('%s/%s.script',scriptpath,filename),'w');
    
    fprintf(fileID,'magnetite 20 C \n');
	meshname = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b, r);
	fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', path, meshname);

	angx = cos(theta/180*pi);
	angy = sin(theta/180*pi)*cos(phi/180*pi);
	angz = sin(theta/180*pi)*sin(phi/180*pi);

	fprintf(fileID, '!angle #%d (theta=%d, phi=%d) \n', ...
            a, round(theta), round(phi));
    fprintf(fileID, 'Set MaxEnergyEvaluations 5000 \n');
    fprintf(fileID, 'external field direction %1.3f %1.3f %1.3f \n', angx, angy, angz);
    fprintf(fileID, 'Uniform Magnetization %1.3f %1.3f %1.3f \n', -angx, -angy, -angz);
    
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
    fclose(fid);
    
    fprintf(fileID,[...
        'Loop field 200 -200 -2'                                       '\r\n'...
        '    external field strength %%field mT '                      '\r\n'...
        '    randomize magnetization 10'                               '\r\n'...
        '    Minimize'                                                 '\r\n'...
        '    WriteMagnetization %s/%s/%s_hyst_$field$mT'       '\r\n'...
        '    WriteHyst %s/%s_hyst'                             '\r\n'...
        'EndLoop'                                                      '\r\n'...
        ],domainpath,filename,filename,hystpath,filename);
    
    for step=200:-2:-200
        fprintf(fileID,[...
            'ReadMagnetization %s/%s/%s_hyst_%dmT.dat'        '\r\n'...
            'Loop field %d 200 2'                                       '\r\n'...
            '    external field strength %%field mT'                        '\r\n'...
            '    randomize magnetization 10'                                '\r\n'...
            '    Minimize '                                                 '\r\n'...
            '    WriteHyst %s/%s_%dmT'                       '\r\n'...
            'EndLoop'                                                   '\r\n'...
            ],domainpath,filename,filename,step,step,hystpath,filename,step);
    end
    fclose(fileID);

end