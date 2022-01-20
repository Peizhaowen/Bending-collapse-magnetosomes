function BentCreateMagnetosomeSphereMesh(x,y,z,d,N,b)
	path = 'c:/magnetosomes/mesh_bent';
	cubitpath = 'C:/magnetosomes/cubit_bent'; 
	filename = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N,b);
	f = fopen(sprintf('%s/%s.jou', cubitpath, filename),'w');
	fprintf(f,'set geometry engine acis\n');
	fprintf(f,'set default element hex\n');
	
    fprintf(f, 'brick x %1.3f y %1.3f z %1.3f\n',x/1000,y/1000,z/1000);
    %fprintf(f, 'volume %d size 0.009\n',1);
    %fprintf(f, 'volume %d scheme Tetmesh\n',1);
	%fprintf(f, 'mesh volume %d\n',1);
    aa = (b/(N-1));
    at = aa *pi/180;
    R = (((d/2)/cos(at/2)) + (x/2))/(tan(at/2));
    r = num2str((R+y/2)*0.001);
    fprintf(f, 'body 1 move 0 0 %s\n',r);
    
    for i = 2:N
        rx = rand(1);
        ry = rand(1);
        fprintf(f, 'body %d copy\n',i-1);
        fprintf(f, 'volume %d rotate %d about %d %d %d \n',i,aa,rx,ry,0);
    end
	fclose(f);
end