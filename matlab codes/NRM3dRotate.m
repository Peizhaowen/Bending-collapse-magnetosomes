function NRM3dRotate(x,y,z,d,N,r,b)
%NRM3dRotate(40,40,40,8,10,1,8)
    domainpath = 'D:/magnetosomes/domainstates_bent3d_NRM/';
    filename1 = sprintf('%dx_%dy_%dz_%dd_%dN_0b_1a.dat', x, y, z, d, N);
    filename2 = sprintf('%dx_%dy_%dz_%dd_%dN_%db_%dr_1a.dat', x, y, z, d, N, b, r);
	newdomainsfilename = sprintf('%s/rot%s', domainpath, filename2);
	olddomainsfilenameb1 = sprintf('%s/NRM%s', domainpath, filename1);
	
 %   olddomainsfilenameb2 = sprintf('%s/%s', domainpath , filename2);
    
	D1 = load(olddomainsfilenameb1);
 %   D2 = load(olddomainsfilenameb2);
    [row,c] = size(D1);
    meshr = row/N ;
 %   aa1 = (b1/(N-1))*pi/180;
 %   aa2 = (b2/(N-1))*pi/180;
    newdomainfile = fopen(newdomainsfilename,'w');
	
	randpath = sprintf('D:/magnetosomes/randangle/randangle.csv'); 
    f2 = fopen(randpath);
    Rand = textscan(f2, ' %f','delimiter',',');
    rand = Rand{1};
    fclose(f2);
    
	for i = 1:9
        rota = b*pi/180;
        for j = 1 + (i-1)*meshr : meshr*i
 %           for k = 1:3
 %              if D2(j,k) >= 0
 %                   fprintf(newdomainfile ,'  %1.6f ',D2(j,k));
 %               else
 %                   fprintf(newdomainfile ,' %1.6f ',D2(j,k));
 %               end
 %          end
            Rot = eul2rotm([rota*(10-i),0,0]);
            rxd = sum(rand(((r-1) * 9 + i) : ((r-1) * 9 + 9)));
			rx = rxd*pi/180;
			Rotr = eul2rotm([0,0,rx]);
            Drot = D1(j,1:3) * Rot * Rotr;
            fprintf(newdomainfile ,'  %1.6f ',Drot);
            fprintf(newdomainfile ,'\n');
        end
    end
	for j = 1 + 9*meshr : meshr*10
		for k = 1:3
			if D1(j,k) >= 0
				fprintf(newdomainfile ,'  %1.6f ',D1(j,k));
            else
				fprintf(newdomainfile ,' %1.6f ',D1(j,k));
            end
        end
        fprintf(newdomainfile ,'\n');
	end
    fclose(newdomainfile);
end