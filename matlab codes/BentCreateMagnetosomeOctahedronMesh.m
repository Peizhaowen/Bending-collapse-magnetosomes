function BentCreateMagnetosomeOctahedronMesh(x,y,z,d,N,b)
	path = 'c:/magnetosomes/mesh_bent';
	cubitpath = 'C:/magnetosomes/cubit_bent'; 
	filename = sprintf('magnetosome_Octahedron_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N,b);
	f = fopen(sprintf('%s/%s.jou', cubitpath, filename),'w');
	fprintf(f,'set geometry engine acis\n');
	fprintf(f,'set default element hex\n');
	

    if b == 0
		fprintf(f, 'create pyramid height %1.3f sides 4 radius %1.3f top 0\n',x/1000,y/1000);
		fprintf(f, 'create pyramid height %1.3f sides 4 radius %1.3f top 0\n',x/1000,y/1000);
		fprintf(f,'body 2 rotate 180 about 10 0 0\n');
		fprintf(f,'body 2 move 0 0 %1.3f\n',-y/1000);
		fprintf(f,'unite 1 with 2\n');
		fprintf(f,'body 1 rotate  45 about 0 0 10\n');
		for i = 3:11
			fprintf(f, 'body 1 copy\n');
			fprintf(f,'volume %d move x %1.6f y 0 z 0\n', i, (x*2+d)*(i-1-5.5)/1000);
        end
        fprintf(f,'volume %d move x %1.6f y 0 z 0\n', 1, (x*2+d)*(1-5.5)/1000);
	else    
		fprintf(f, 'create pyramid height %1.3f sides 4 radius %1.3f top 0\n',x/1000,y/1000);
		fprintf(f, 'create pyramid height %1.3f sides 4 radius %1.3f top 0\n',x/1000,y/1000);
		fprintf(f,'body 2 rotate 180 about 10 0 0\n');
		fprintf(f,'body 2 move 0 0 %1.3f\n',-y/1000);
		fprintf(f,'unite 1 with 2\n');
		fprintf(f,'body 1 rotate  45 about 0 0 10\n');
		
        aa = (b/(N-1));
        at = (b/(N-1))*pi/180;
        R = (d/2)/cos(at/2) + x/(tan(at/2));
        r = num2str((-R-y)*0.001);
	
        str_move = strcat( 'body 1' ,' move 0 0',32,r);
        fprintf(f, '%s\n',str_move);
		
	    for i = 2:10 
		    fprintf(f, 'body 1 copy\n');
            id = num2str(i+1);
            as = num2str((-i+5.5)*aa);
            str_rot = strcat('rotate volume',32,id,' about Y angle',32,as);
            fprintf(f, '%s\n',str_rot);
	    end
	
	    as1 = num2str((4.5)*aa);
	    str_rot1 = strcat('rotate volume 1 about Y angle',32,as1);
        fprintf(f, '%s\n',str_rot1);
	end

	fprintf(f, 'volume %d size 0.009\n',1);
	fprintf(f, 'volume %d scheme Tetmesh\n',1);
	fprintf(f, 'mesh volume %d\n',1);

	for  j = 3:11
		fprintf(f, 'volume %d size 0.009\n',j);
		fprintf(f, 'volume %d scheme Tetmesh\n',j);
		fprintf(f, 'mesh volume %d\n',j);
	end

	fprintf(f, 'block 1 volume all\n');
	fprintf(f, 'block 1 element type tetra4\n');
	fprintf(f, 'set patran export groups on\n');
	fprintf(f,'export patran "%s/%s.pat" \n', path, filename);
	fclose(f);

end

