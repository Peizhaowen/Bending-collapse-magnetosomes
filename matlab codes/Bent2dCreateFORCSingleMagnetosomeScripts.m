function filename = Bent2dCreateFORCSingleMagnetosomeScripts(x,y,z,d,N,b,a,theta,phi)

    path = 'mesh_bent';
    domainpath = 'domainstates_bent2d_single_FORC';
    merrillpath = 'D:/magnetosomes';
    scriptpath = 'D:/magnetosomes/scripts/hysteresis_bent2d_single_FORC';
    hystpath = 'hysteresis_bent2d_single_FORC';
    filename = sprintf('2d_FORC_%dx_%dy_%dz_%dd_%dN_%db_%da', x, y, z, d, N, b,a);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, domainpath), filename);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, hystpath));
    [~,~,~] = mkdir(sprintf('%s',scriptpath));
    
    fileID = fopen(sprintf('%s/%s.script',scriptpath,filename),'w');
    fprintf(fileID,'magnetite 20 C \n');
	meshname = sprintf('magnetosome_cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
	fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', path, meshname);

	angx = cos(theta/180*pi);
	angy = sin(theta/180*pi)*cos(phi/180*pi);
	angz = sin(theta/180*pi)*sin(phi/180*pi);
    
	for i = 1:10
		rotangley = (b*(-i+5.5)/(N-1))*pi/180;
		fprintf(fileID, 'CubicRotation 0 %1.4f %1.4f SD = %d \n',rotangley+0.6154,-0.7854,i); 
    end

	fprintf(fileID, '!angle #%d (theta=%d, phi=%d) \n', ...
            a, round(theta), round(phi));
    fprintf(fileID, 'Set MaxEnergyEvaluations 5000 \n');
	fprintf(fileID, 'external field direction %1.3f %1.3f %1.3f \n', angx, angy, angz);
	fprintf(fileID, 'Uniform Magnetization %1.3f %1.3f %1.3f \n', -angx, -angy, -angz);

    fprintf(fileID,[...
        'Loop field 200 -200 -2'                                         '\r\n'...
        '    external field strength %%field mT '                        '\r\n'...
        '    randomize magnetization 10'                                 '\r\n'...
        '    Minimize'                                                   '\r\n'...
        '    WriteMagnetization %s/%s/%s_hyst_$field$mT'                 '\r\n'...
        '    WriteHyst %s/%s_hyst'                                       '\r\n'...
        'EndLoop'                                                        '\r\n'...
        ],domainpath,filename,filename,hystpath,filename);

    for step=200:-2:-200
        fprintf(fileID,[...
            'ReadMagnetization %s/%s/%s_hyst_%dmT.dat'                  '\r\n'...
            'Loop field %d 200 2'                                       '\r\n'...
            '    external field strength %%field mT'                    '\r\n'...
            '    randomize magnetization 10'                            '\r\n'...
            '    Minimize '                                             '\r\n'...
            '    WriteHyst %s/%s_%dmT'                                  '\r\n'...
            'EndLoop'                                                   '\r\n'...
            ],domainpath,filename,filename,step,step,hystpath,filename,step);
    end
    fclose(fileID);
    
end