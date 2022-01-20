function scriptfilename = BentCuboctahedronCreateIRMScript(x,y,z,d,N,b,a,theta,phi)
	path = 'mesh_bent';
	domainpath = 'domainstates_bent_IRM_cuboctahedron';
	merrillpath = 'D:/magnetosomes';
	scriptpath = 'D:/magnetosomes/scripts/IRM_bent_cuboctahedron';
	IRMpath = 'IRM_bent_cuboctahedron';
	filename = sprintf('IRM_cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
	scriptfilename = sprintf('IRM_cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db_%ga', x, y, z, d, N, b, a);
	[~,~,~] = mkdir(sprintf('%s/%s', merrillpath, domainpath), filename);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, IRMpath));
    [~,~,~] = mkdir(sprintf('%s', scriptpath));
	fileID = fopen(sprintf('%s/%s_%da.script', scriptpath, filename, a),'w');

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
    % fprintf(fileID, 'CubicRotation 0 0.6154 -0.7854  \n'); 
    
	fprintf(fileID, '!angle #%d (theta=%d, phi=%d) \n', ...
            a, round(theta), round(phi));
    fprintf(fileID, 'Set MaxEnergyEvaluations 10000 \n');
	fprintf(fileID, 'external field direction %1.3f %1.3f %1.3f \n', angx, angy, angz);
	fprintf(fileID, 'Uniform Magnetization %1.3f %1.3f %1.3f \n', -angx, -angy, -angz);
	
	fprintf(fileID, 'Randomize Magnetization 10\n');
	fprintf(fileID, 'External field strength 300 mT\n');
	fprintf(fileID, 'Minimize\n');
	fprintf(fileID, 'WriteHyst %s/%s_%da \n', IRMpath, filename, a);
	fprintf(fileID, 'Randomize Magnetization 10\n');
	fprintf(fileID, 'External field strength 0 mT\n');
	fprintf(fileID, 'Minimize\n');
	% fprintf(fileID, 'WriteMagnetization %s/%s/%s_300_mT_%da \n',domainpath, filename, filename, a); 
    fprintf(fileID, 'WriteHyst %s/%s_%da \n', IRMpath, filename, a);
	
	IRMMerrillLoop(fileID, IRMpath, domainpath, filename, ...
		a, 0, -100, -5);
	IRMMerrillLoop(fileID, IRMpath, domainpath, filename, ...
		a, -120, -300, -20);
		
	fprintf(fileID, '\n');
	fclose(fileID);
end