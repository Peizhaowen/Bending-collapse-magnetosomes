function ThermalNRMDataRotate3d(x,y,z,d,N,r,b)
%  ThermalNRMDataRotate3d(40,40,40,8,10,1,50)
randpath = sprintf('D:/magnetosomes/randangle/randangle.csv');
fid = fopen(randpath);
Rand = textscan(fid, ' %f','delimiter',',');
rand = Rand{1};
merrillpath = 'D:/magnetosomes_thermal';
groundstatepath = 'groundstates_bent_read3d';
domainpath = 'D:/magnetosomes_thermal/old/groundstates_bent';
filename = sprintf('3dco_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b, r);
[~,~,~] = mkdir(sprintf('%s/%s', merrillpath, groundstatepath), [filename '_p']);
[~,~,~] = mkdir(sprintf('%s/%s', merrillpath, groundstatepath), [filename '_n']);
T = [0:20:560 575];
for di = 1:2
    if di == 1
        direction = 'p';
    end
    if di == 2
        direction = 'n';
    end
    for n = 1:length(T)
        subfolder2 = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_0b', x, y, z, d, N);
        filename2 = sprintf('co_%gx_%gy_%gz_%gd_%dN_0b_%gT', x, y, z, d, N, T(n));
        domainsfile0b = sprintf('%s/%s_%s/%s.dat', domainpath, subfolder2,direction, filename2);
        newdomainsfile = sprintf('%s/%s/%s_%s/%s_%gT.dat', merrillpath, groundstatepath, filename, direction, filename, T(n));
        D = load(domainsfile0b);
        [row,~] = size(D);
        meshr = row/N;
        newfile = fopen(newdomainsfile,'w');
        
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
end
end