function BentCreateMagnetosomeMesh(x,y,z,d,N,b)
	path = 'D:/magnetosomes/mesh_bent';
	cubitpath = 'D:/magnetosomes/cubit_bent'; 
	filename = sprintf('magnetosome_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N,b);
	f = fopen(sprintf('%s/%s.jou', cubitpath, filename),'w');
	fprintf(f,'set geometry engine acis\n');
	fprintf(f,'set default element hex\n');
	

    if b == 0
		fprintf(f, 'brick x %1.6f y %1.6f z %1.6f\n',x/1000,y/1000,z/1000);
        fprintf(f, 'volume 1 size 0.009\n');
		fprintf(f, 'volume 1 scheme Tetmesh\n');
		fprintf(f, 'mesh volume 1\n');
		for i = 2:10
			fprintf(f, 'body 1 copy\n');
			fprintf(f,'volume %d move x %1.6f y 0 z 0\n', i, (x+d)*(i-5.5)/1000);
		end
		fprintf(f,'volume %d move x %1.6f y 0 z 0\n', 1, (x+d)*(1-5.5)/1000);
	else    
		fprintf(f, 'brick x %1.6f y %1.6f z %1.6f\n',x/1000,y/1000,z/1000);
        fprintf(f, 'volume 1 size 0.009\n');
		fprintf(f, 'volume 1 scheme Tetmesh\n');
		fprintf(f, 'mesh volume 1\n');
		aa = (b/(N-1));
        at = (b/(N-1))*pi/180;
        R = (((d/2)/cos(at/2)) + (x/2))/(tan(at/2));
        r = num2str((-R-y/2)*0.001);
	
        str_move = strcat( 'body 1' ,' move 0 0',32,r);
        fprintf(f, '%s\n',str_move);
		
	    for i = 2:10 
		    fprintf(f, 'body 1 copy\n');
            id = num2str(i);
            as = num2str((-i+5.5)*aa);
            str_rot = strcat('rotate volume',32,id,' about Y angle',32,as);
            fprintf(f, '%s\n',str_rot);
	    end
	
	    as1 = num2str((4.5)*aa);
	    str_rot1 = strcat('rotate volume 1 about Y angle',32,as1);
        fprintf(f, '%s\n',str_rot1);
        
        r2 = (R + y/2)*0.001;
        for j = 1:10
            fprintf(f,'volume %d move 0 0 %1.6f\n', j, r2);
        end
    end

	for k = 1:10
		fprintf(f, 'block %d volume %d\n',k,k);
		fprintf(f, 'block %d element type tetra4\n',k);
	end
	
	fprintf(f, 'set patran export groups on\n');
    fprintf(f,'export patran "%s/%s.pat" \n',path, filename);
	fclose(f);

end

