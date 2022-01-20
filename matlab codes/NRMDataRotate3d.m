function NRMDataRotate3d(x,y,z,d,N,r,b)
%  NRMDataRotate3d(40,40,40,8,10,1,30)
    domainpath = 'D:/magnetosomes_NRM/scripts/NRM_bent3d';
    filename = sprintf('3d%dx_%dy_%dz_%dd_%dN_%dr', x, y, z, d, N, r);
    filename0 = sprintf('%dx_%dy_%dz_%dd_%dN', x, y, z, d, N);
    domainsfile0b = sprintf('%s/co_%s_0b_20T.dat', domainpath, filename0);
    [~,~,~] = mkdir(sprintf('%s/%s', domainpath, filename));
    newdomainsfile = sprintf('%s/%s/%s_%db_0_mT_1a.dat', domainpath, filename, filename,b);
    D = load(domainsfile0b);
    [row,~] = size(D);
    meshr = row/N;
    newfile = fopen(newdomainsfile,'w');
    
    randpath = sprintf('D:/magnetosomes/randangle/randangle.csv'); 
    fid = fopen(randpath);
    Rand = textscan(fid, ' %f','delimiter',',');
    rand = Rand{1};
	
   for i = 1:N-1
		id = (r-1) * 9 + i;
	    rasingle(i) = rand(id)*pi/180;
	end
	
	for i = 1:N-1
		rotangle = b*pi/180;
		Rot =[1,0,0;0,1,0;0,0,1];
        for j = i:N-1
            Rot = Rot*rotz(-rotangle)*rotx(-rasingle(j));
        end
        for j = 1 + (i-1)*meshr : meshr*i
             M_rot = D(j,4:6)* Rot;
             for m = 1:3
                 if  D(j,m)>=0
                     fprintf(newfile ,'  %1.6f ',D(j,m));
                 else
                     fprintf(newfile ,' %1.6f ',D(j,m));
                 end
             end
             for m = 1:3
                 if  M_rot(m)>=0
                     fprintf(newfile ,'  %1.6f ', M_rot(m));
                 else
                     fprintf(newfile ,' %1.6f ', M_rot(m));
                 end
             end
            fprintf(newfile ,'\n');
        end
    end
    
    for j = 1 + 9*meshr : meshr*10
        for m = 1:6
            if  D(j,m)>=0
                fprintf(newfile ,'  %1.6f ',D(j,m));
            else
                fprintf(newfile ,' %1.6f ',D(j,m));
            end
        end
        fprintf(newfile ,'\n');
    end

    fclose(newfile);
end