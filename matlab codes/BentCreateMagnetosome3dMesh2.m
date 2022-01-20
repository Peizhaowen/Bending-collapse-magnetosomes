function BentCreateMagneto3dMesh2(x,y,z,d,N,b)
	path = 'c:/magnetosomes/mesh_3dbent';
	cubitpath = 'C:/magnetosomes/cubit_3dbent'; 
	[~,~,~] = mkdir(path);
	[~,~,~] = mkdir(cubitpath);
	filename = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N,b);
	f = fopen(sprintf('%s/%s.jou', cubitpath, filename),'w');
	fprintf(f,'set geometry engine acis\n');
	fprintf(f,'set default element hex\n');
	
    fprintf(f, 'brick x %1.3f y %1.3f z %1.3f\n',x/1000,y/1000,z/1000);
    %fprintf(f, 'volume %d size 0.009\n',1);
    %fprintf(f, 'volume %d scheme Tetmesh\n',1);
	%fprintf(f, 'mesh volume %d\n',1);
    
    for i = 1:N-1
        rx = rand(1)-0.5;
		ry = rand(1)-0.5;
        rz = rand(1)-0.5;
        fprintf(f, 'body %d copy\n',i);
        for k =1:i
            fprintf(f, 'body %d move %1.3f 0 0\n', k, (x+d)/1000);
        end
        for j = 1:i
            fprintf(f, 'body %d rotate %d about %d %d %d \n', j, b, rx，ry, rz);
        end
    end
	fclose(f);
end