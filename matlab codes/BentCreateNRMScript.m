function scriptfilename = BentCreateNRMScript(x,y,z,d,N,a,theta,phi)
	path = 'mesh_bent';
	domainpath = 'domainstates_bent_NRM';
	merrillpath = 'D:/magnetosomes';
	scriptpath = 'D:/magnetosomes/scripts/NRM_bent';
	NRMpath = 'NRM_bent';
	remanencepath = sprintf('domainstates_bent/%dx_%dy_%dz_%dd_%dN_0b', x, y, z, d, N);
	filename = sprintf('NRM%dx_%dy_%dz_%dd_%dN', x, y, z, d, N);
	scriptfilename = sprintf('NRM%dx_%dy_%dz_%dd_%dN_%ga', x, y, z, d, N, a);
	[~,~,~] = mkdir(sprintf('%s/%s', merrillpath, domainpath), filename);
    [~,~,~] = mkdir(scriptpath);
	fileID = fopen(sprintf('%s/%s_%da.script', scriptpath, filename, a),'w')

	fprintf(fileID,'magnetite 20 C \n');
	fprintf(fileID,'Set MaxMeshNumber 31\n');
	for i = 0:1:30
		meshname = sprintf('magnetosome_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, i*10);
		fprintf(fileID, 'ReadMesh %d %s/%s.pat \n', i+1, path, meshname);
    end
    
    fprintf(fileID, '!angle #%d (theta=%d, phi=%d) \n', ...
		a, round(theta), round(phi));
	angx = cos(theta/180*pi);
	angy = sin(theta/180*pi)*cos(phi/180*pi);
	angz = sin(theta/180*pi)*sin(phi/180*pi);
    fprintf(fileID, 'external field direction %1.3f %1.3f %1.3f \n', angx, angy, angz);	
    
	fprintf(fileID, 'LoadMesh 1 \n');
	fprintf(fileID, 'ReadMagnetization scripts/NRM_bent/%dx_%dy_%dz_%dd_%dN_0b_0_mT_%da.dat \n', x, y, z, d, N, a);
	fprintf(fileID, 'WriteMagnetization %s/%s/%s_0b_%da\n',domainpath, filename, filename, a); 
    fprintf(fileID, 'WriteHyst %s/remesh_%s_%da \n', NRMpath, filename, a);
    fprintf(fileID, 'WriteHyst %s/minimize_%s_%da \n', NRMpath, filename, a);

	for j = 2:31
		fprintf(fileID, 'Remesh %d \n',j);
		fprintf(fileID, 'WriteMagnetization %s/%s/remesh_%s_%db_%da\n',domainpath, filename, filename,(j-1)*30,a); 
		fprintf(fileID, 'WriteHyst %s/remesh_%s_%da \n', NRMpath, filename, a);
		fprintf(fileID, 'Cubic Anisotropy \n'); 
		for k = 1:10
			rotangley = ((j-1)*30*(-k+5.5)/(N-1))*pi/180;
			fprintf(fileID, 'CubicRotation 0 %1.4f %1.4f SD = %d \n',rotangley+0.6154,-0.7854,k);
		end
		fprintf(fileID, 'External field strength 0 mT\n');
		fprintf(fileID, 'Minimize\n');
		fprintf(fileID, 'WriteMagnetization %s/%s/minimize_%s_%db_%da\n',domainpath, filename, filename,(j-1)*30,a); 
		fprintf(fileID, 'WriteHyst %s/minimize_%s_%da \n', NRMpath, filename, a);
	end
		
	fprintf(fileID, '\n');
	fclose(fileID);
end