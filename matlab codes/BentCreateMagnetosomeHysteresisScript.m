function scriptfilename = BentCreateMagnetosomeHysteresisScript(x,y,z,d,N,b,a,theta,phi)
	path = 'mesh_bent';
	domainpath = 'domainstates_bent';
	merrillpath = 'D:/magnetosomes';
	scriptpath = 'D:/magnetosomes/scripts/hysteresis_bent';
	hysteresispath = 'hysteresis_bent';
	filename = sprintf('%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
	scriptfilename = sprintf('%dx_%dy_%dz_%dd_%dN_%db_%ga', x, y, z, d, N, b, a);

	[~,~,~] = mkdir(sprintf('%s/%s', merrillpath, domainpath), filename);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, hysteresispath));
    [~,~,~] = mkdir(sprintf('%s', scriptpath));
	fileID = fopen(sprintf('%s/%s_%da.script', scriptpath, filename, a),'w');

	fprintf(fileID,'magnetite 20 C \n');
	meshname = sprintf('magnetosome_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
	fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', path, meshname);

	angx = cos(theta/180*pi);
	angy = sin(theta/180*pi)*cos(phi/180*pi);
	angz = sin(theta/180*pi)*sin(phi/180*pi);
    
	for i = 1:10
		rotangley = (b*(-i+5.5)/(N-1))*pi/180;
		fprintf(fileID, 'CubicRotation 0 %1.4f %1.4f SD = %d \n',rotangley+0.6154,-0.7854,i); 
    end
    
    % fprintf(fileID, 'CubicRotation 0 0.6154 -0.7854  \n');     
    
	fprintf(fileID, '!angle #%d (theta=%d, phi=%d) \n', ...
            a, round(theta), round(phi));
    fprintf(fileID, 'Set MaxEnergyEvaluations 20000 \n');
	fprintf(fileID, 'external field direction %1.3f %1.3f %1.3f \n', angx, angy, angz);
	fprintf(fileID, 'Uniform Magnetization %1.3f %1.3f %1.3f \n', -angx, -angy, -angz);
	
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



