function scriptfilename = Bent3dCreateIRMScript(x,y,z,d,N,b,r,a,theta,phi)
	path = 'mesh_bent3d';
	domainpath = 'domainstates_bent3d_IRM';
	merrillpath = 'D:/magnetosomes_3d';
	scriptpath = 'D:/magnetosomes_3d/scripts/IRM_bent3d';
	IRMpath = 'IRM_bent3d';
	filename = sprintf('3dIRM%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b, r);
	scriptfilename = sprintf('3dIRM%dx_%dy_%dz_%dd_%dN_%db_%dr_%ga', x, y, z, d, N, b, r, a);
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
	
	
	fprintf(fileID, 'Randomize Magnetization 10\n');
	fprintf(fileID, 'External field strength 300 mT\n');
	fprintf(fileID, 'Minimize\n');
	fprintf(fileID, 'WriteHyst %s/%s_%da \n', IRMpath, filename, a);
	fprintf(fileID, 'Randomize Magnetization 10\n');
	fprintf(fileID, 'External field strength 0 mT\n');
	fprintf(fileID, 'Minimize\n');
	fprintf(fileID, 'WriteMagnetization %s/%s/%s_300_mT_%da \n',domainpath, filename, filename, a); 
    fprintf(fileID, 'WriteHyst %s/%s_%da \n', IRMpath, filename, a);
	
	IRMMerrillLoop(fileID, IRMpath, domainpath, filename, ...
		a, 0, -100, -5);
	IRMMerrillLoop(fileID, IRMpath, domainpath, filename, ...
		a, -120, -300, -20);
		
	fprintf(fileID, '\n');
	fclose(fileID);
end