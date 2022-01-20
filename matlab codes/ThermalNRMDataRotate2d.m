function ThermalNRMDataRotate2d(x,y,z,d,N,b,crystal)
%  ThermalNRMDataRotate2d(40,40,40,8,10,300,'c')
  
    if crystal == 'c'
        subfolder = sprintf('%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
        subfolder2 = sprintf('%gx_%gy_%gz_%gd_%dN_0b', x, y, z, d, N);
    end
    if crystal == 'co'
        subfolder = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
        subfolder2 = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_0b', x, y, z, d, N);
    end
    merrillpath = 'D:/magnetosomes_thermal';
    groundstatepath = 'groundstates_bent_read';
    domainpath = 'D:/magnetosomes_thermal/old/groundstates_bent';
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, groundstatepath), [subfolder '_p']);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, groundstatepath), [subfolder '_n']);
    T = [0:20:560 575];
    for di = 1:2
        if di == 1
            direction = 'p';
        end
        if di == 2
            direction = 'n';
        end
        for n = 1:length(T)
            filename = sprintf('%s_%gx_%gy_%gz_%gd_%dN_%db_%gT', crystal, x, y, z, d, N, b, T(n));
            filename2 = sprintf('%s_%gx_%gy_%gz_%gd_%dN_0b_%gT', crystal, x, y, z, d, N, T(n));
            domainsfile0b = sprintf('%s/%s_%s/%s.dat', domainpath, subfolder2,direction, filename2);
            newdomainsfile = sprintf('%s/%s/%s_%s/%s.dat', merrillpath, groundstatepath, subfolder, direction, filename);
            D = load(domainsfile0b);
            [r,~] = size(D);
            meshr = r/N;
            aa = (b/(N-1))*pi/180;
            R = (((d/2)/cos(aa/2)) + (x/2))/(tan(aa/2));
            r1 = (R + y/2)*0.001;
            newfile = fopen(newdomainsfile,'w');
            for i = 1:10
                ai = (-i+5.5)*aa;
                r2 = (-i+5.5)*(x+d)*0.001;
                for j = 1 + (i-1)*meshr : meshr*i
                    Rot = roty(-ai);
                    D(j,1:3);
                    P1 = D(j,1)+r2;
                    P3 = D(j,3)-r1;
                    P_rot = [P1 D(j,2) P3] * Rot;
                    M_rot = D(j,4:6)* Rot;
                    for m = 1:2
                        if  P_rot(m)>=0
                            fprintf(newfile ,'  %1.6f ', P_rot(m));
                        else
                            fprintf(newfile ,' %1.6f ', P_rot(m));
                        end
                    end
                    P3 = P_rot(3)+r1;
                    if  P3>=0
                        fprintf(newfile ,'  %1.6f ', P3);
                    else
                        fprintf(newfile ,' %1.6f ', P3);
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
            fclose(newfile);
        end
    end
end