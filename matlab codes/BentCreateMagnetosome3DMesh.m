function BentCreateMagnetosome3DMesh(x,y,z,d,N,b)
	path = 'c:/magnetosomes/mesh_bent';
	cubitpath = 'C:/magnetosomes/cubit_bent'; 
	filename = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N,b);
	f = fopen(sprintf('%s/%s.jou', cubitpath, filename),'w');
	fprintf(f,'set geometry engine acis\n');
	fprintf(f,'set default element hex\n');
	
    fprintf(f, 'brick x %1.3f y %1.3f z %1.3f\n',x/1000,y/1000,z/1000);
    fprintf(f, 'volume %d size 0.009\n',1);
	fprintf(f, 'volume %d scheme Tetmesh\n',1);
	fprintf(f, 'mesh volume %d\n',1);
	for i = 2:10
		fprintf(f, 'body 1 copy\n');
		fprintf(f,'volume %d move x %1.6f y 0 z 0\n', i, (x+d)*(i-5.5)/1000);
	end
	fprintf(f,'volume %d move x %1.6f y 0 z 0\n', 1, (x+d)*(1-5.5)/1000);
	for j = 2:9
		for i = j:10 
            rx = 2*(rand(1)-0.5);
            ry = 2*(rand(1)-0.5);
			fprintf(f, 'volume %d rotate %d about %d %d %d \n',i,b,rx,ry,0);
            fprintf(f, 'volume %d rotate %d about %d %d %d \n',i-1,-b,rx,ry,0);
            fprintf(f, 'volume %d rotate %d about %d %d %d \n',i,-b,rx,ry,0);
		end
    end
    fprintf(f, 'volume 10 rotate %d about %d %d %d \n',b,2*(rand(1)-0.5),2*(rand(1)-0.5),0);
		
	fclose(f);

end

