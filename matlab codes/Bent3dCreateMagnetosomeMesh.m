function Bent3dCreateMagnetosomeMesh(x,y,z,d,N,b,r)
	path = 'D:/magnetosomes/mesh_bent3d';
	cubitpath = 'D:/magnetosomes/cubit_bent3d'; 
	[~,~,~] = mkdir(path);
	[~,~,~] = mkdir(cubitpath);
	filename = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b, r);
	f = fopen(sprintf('%s/%s.jou', cubitpath, filename),'w');
	fprintf(f,'set geometry engine acis\n');
	fprintf(f,'set default element hex\n');
	
	fprintf(f,'create pyramid height %1.6f sides 4 radius %1.6f top 0\n',x/1000,y/1000);
	fprintf(f,'create pyramid height %1.6f sides 4 radius %1.6f top 0\n',x/1000,y/1000);
	fprintf(f,'body 2 rotate 180 about 10 0 0\n');
	fprintf(f,'body 2 move 0 0 %1.6f\n',-y/1000);
	fprintf(f,'unite 1 with 2\n');
	fprintf(f,'body 1 rotate  45 about 0 0 10\n');
	fprintf(f,'body 1 move 0 0 %1.6f\n',y/1000/2);
	fprintf(f,'brick x %1.6f\n',x/1000);
	fprintf(f,'intersect 1 with 3\n');
	fprintf(f, 'volume 3 size 0.009\n');
	fprintf(f, 'volume 3 scheme Tetmesh\n');
	fprintf(f, 'mesh volume 3\n');
    
    randpath = sprintf('D:/magnetosomes/randangle/randangle.csv'); 
    fid = fopen(randpath);
    Rand = textscan(fid, ' %f','delimiter',',');
    rand = Rand{1};
    
    for i = 1:N-1
        id = (r-1) * 9 + i;
        rz = rand(id);
        fprintf(f, 'body %d copy\n',i+2);
        for k =1:i
            if b < 45
                fprintf(f, 'body %d move %1.3f 0 0\n', k+2, (d+x*(1+(1/cos((20+b*20/45)*pi/180)-1)))/1000);
            else
                fprintf(f, 'body %d move %1.3f 0 0\n', k+2, (d+x*(1+(1/cos(30*pi/180)-1)))/1000);
            end
        end
        for j = 1:i
            fprintf(f, 'body %d rotate %d about Z \n', j+2, b);
            fprintf(f, 'body %d rotate %d about X \n', j+2, rz);
        end
    end
    
    for k = 1:10
        fprintf(f, 'block %d volume %d\n',k,k+2);
		fprintf(f, 'block %d element type tetra4\n',k);
    end
    
    
    fprintf(f, 'set patran export groups on\n');
    fprintf(f, 'export patran "%s/%s.pat" \n',path,filename);
	fprintf(f, 'new\n');
	fclose(f);
    
end