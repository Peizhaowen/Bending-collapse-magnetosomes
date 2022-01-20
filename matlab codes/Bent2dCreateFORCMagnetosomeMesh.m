function Bent2dCreateFORCMagnetosomeMesh(x,y,z,d,N,b)
    % Bent2dCreateFORCMagnetosomeMesh(40,40,40,8,10,300)
	path = 'D:/magnetosomes/mesh_bent2d_FORC';
	cubitpath = 'D:/magnetosomes/cubit_bent2d_FORC'; 
	[~,~,~] = mkdir(path);
	[~,~,~] = mkdir(cubitpath);
    for n = 1:20
        filename = sprintf('magnetosome2d_FORC_%dx_%dy_%dz_%dd_%dN_%db_model%d', x, y, z, d, N, b, n);
        f = fopen(sprintf('%s/%s.jou', cubitpath, filename),'w');
        filenameanis = sprintf('Anis_magnetosome2d_FORC_%dx_%dy_%dz_%dd_%dN_%db_model%d', x, y, z, d, N, b, n);
        fileAnis = fopen(sprintf('%s/%s.txt', cubitpath, filenameanis),'w');
        filenamepos = sprintf('Pos_magnetosome2d_FORC_%dx_%dy_%dz_%dd_%dN_%db_model%d', x, y, z, d, N, b, n);
        filepos = fopen(sprintf('%s/%s.txt', cubitpath, filenamepos),'w');
        fprintf(f,'set geometry engine acis\n');
        fprintf(f,'set default element hex\n');
        
        xr = -3+6.*rand(1,20);
        yr = -3+6.*rand(1,20);
        zr = -3+6.*rand(1,20);
        bzr = rand(1,20).*360;
        bxr = rand(1,20).*180;
        
        for r = 1:20
            fprintf(f,'create pyramid height %1.6f sides 4 radius %1.6f top 0\n',x/1000,y/1000);
            fprintf(f,'create pyramid height %1.6f sides 4 radius %1.6f top 0\n',x/1000,y/1000);
            fprintf(f,'body %d rotate 180 about 10 0 0\n',12*(r-1)+2);
            fprintf(f,'body %d move 0 0 %1.6f\n',12*(r-1)+2,-y/1000);
            fprintf(f,'unite %d with %d\n',12*(r-1)+1,12*(r-1)+2);
            fprintf(f,'body %d rotate  45 about 0 0 10\n',12*(r-1)+1);
            fprintf(f,'body %d move 0 0 %1.6f\n',12*(r-1)+1,y/1000/2);
            fprintf(f,'brick x %1.6f\n',x/1000);
            fprintf(f,'intersect %d with %d\n',12*(r-1)+1,12*(r-1)+3);
            fprintf(f, 'volume %d size 0.009\n',12*(r-1)+3);
            fprintf(f, 'volume %d scheme Tetmesh\n',12*(r-1)+3);
            fprintf(f, 'mesh volume %d\n',12*(r-1)+3);
            if b ==0
                for i = 2:10
                    fprintf(f, 'body %d copy\n',12*(r-1)+3);
                    fprintf(f,'volume %d move x %1.6f y 0 z 0\n', 12*(r-1)+i+2, (x+d)*(i-5.5)/1000);
                end
                fprintf(f,'volume %d move x %1.6f y 0 z 0\n', 12*(r-1)+3, (x+d)*(1-5.5)/1000);
            else
                aa = (b/(N-1));
                at = (b/(N-1))*pi/180;
                R = (((d/2)/cos(at/2)) + (x/2))/(tan(at/2));
                r1 = (-R-y/2)*0.001;
                fprintf(f, 'body %d move 0 0 %1.6f \n',12*(r-1)+3,r1);
                
                for i = 2:10
                    fprintf(f, 'body %d copy\n',12*(r-1)+3);
                    id =12*(r-1)+i+2;
                    as = (-i+5.5)*aa;
                    fprintf(f, 'rotate volume %d about Y angle %1.6f \n',id, as);
                end
                fprintf(f, 'rotate volume %d about Y angle %1.6f \n',12*(r-1)+3, 4.5*aa);
                
                r2 = (R + y/2)*0.001;
                for j = 3:12
                    fprintf(f,'volume %d move 0 0 %1.6f\n', 12*(r-1)+j, r2);
                end
            end
            
            for m = 1:10
                fprintf(f, 'body %d rotate %d about Z \n', 12*(r-1)+m+2, bzr(r));
                fprintf(f, 'body %d rotate %d about X \n', 12*(r-1)+m+2, bxr(r));
            end
            
            for m = 1:10
                fprintf(f, 'body %d move %1.3f %1.3f %1.3f\n',12*(r-1)+m+2,xr(r),yr(r),zr(r));
            end
            
            for k = 1:10
                fprintf(f, 'block %d volume %d\n',10*(r-1)+k,12*(r-1)+k+2);
                fprintf(f, 'block %d element type tetra4\n',10*(r-1)+k);
            end
            
            for i = 1:N-1
                [Rrot,~] =Bent2dGetFORCAnisaxis(x,y,z,d,N,b,i,bzr(r),bxr(r),xr(r),yr(r),zr(r));
                fprintf(fileAnis, 'CubicAxes %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f SD = %d \n',...
                    Rrot(1,1),Rrot(1,2),Rrot(1,3),Rrot(2,1),Rrot(2,2),Rrot(2,3),Rrot(3,1),Rrot(3,2),Rrot(3,3), 10*(r-1)+i);
            end
            [Rrot,pos] =Bent2dGetFORCAnisaxis(x,y,z,d,N,b,9,bzr(r),bxr(r),xr(r),yr(r),zr(r));
            fprintf(fileAnis, 'CubicAxes %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f SD = %d \n',...
                Rrot(1,1),Rrot(1,2),Rrot(1,3),Rrot(2,1),Rrot(2,2),Rrot(2,3),Rrot(3,1),Rrot(3,2),Rrot(3,3), 10*(r-1)+10);
            
            for i = 1:10
                fprintf(filepos, '%1.9f %1.9f %1.9f\n',...
                pos(i,1),pos(i,2),pos(i,3));
            end
        end
        
        fprintf(f, 'set patran export groups on\n');
        fprintf(f, 'export patran "%s/%s.pat" \n',path,filename);
        % fprintf(f, 'new\n');
        fclose(f);
        fclose(fileAnis);
        fclose(filepos);
    end
end