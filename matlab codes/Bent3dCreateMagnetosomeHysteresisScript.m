function scriptfilename = Bent3dCreateMagnetosomeHysteresisScript(x,y,z,d,N,b,r,a,theta,phi)
	path = 'mesh_bent3d';
	domainpath = 'domainstates_bent3d';
	merrillpath = 'D:/magnetosomes_3d';
	scriptpath = 'D:/magnetosomes_3d/scripts/hysteresis_bent3d';
	hysteresispath = 'hysteresis_bent3d';
	filename = sprintf('3d%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b, r);
	scriptfilename = sprintf('3d%dx_%dy_%dz_%dd_%dN_%db_%dr_%ga', x, y, z, d, N, b, r, a);
	[~,~,~] = mkdir(sprintf('%s/%s', merrillpath, domainpath), filename);
	fileID = fopen(sprintf('%s/%s_%da.script', scriptpath, filename, a),'w');

	fprintf(fileID,'magnetite 20 C \n');
	meshname = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b, r);
	fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', path, meshname);

	angx = cos(theta/180*pi);
	angy = sin(theta/180*pi)*cos(phi/180*pi);
	angz = sin(theta/180*pi)*sin(phi/180*pi);

    fprintf(fileID, '!angle #%d (theta=%d, phi=%d) \n', ...
        a, round(theta), round(phi));
    fprintf(fileID, 'Set MaxEnergyEvaluations 10000 \n');
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

	MerrillLoop(fileID, hysteresispath, domainpath, filename, ...
		a, -300, -100, 20);
	MerrillLoop(fileID, hysteresispath, domainpath, filename, ...
		a, -90, -0, 10);
	MerrillLoop(fileID, hysteresispath, domainpath, filename, ...
		a, 1, 5, 1);
	MerrillLoop(fileID, hysteresispath, domainpath, filename, ...
		a, 10, 100, 5);
	MerrillLoop(fileID, hysteresispath, domainpath, filename, ...
		a, 120, 300, 20);

	fprintf(fileID, '\n');
	fclose(fileID);

end



