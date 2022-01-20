function ThermalNRMDataRotateSingleInAChain2d(x,y,z,d,N,b,crystal)
%  ThermalNRMDataRotateSingleInAChain2d(40,40,40,3,10,0,'c')
  
    if crystal == 'c'
        subfolder = sprintf('%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
        subfolder2 = sprintf('%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
    end
    if crystal == 'co'
        subfolder = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
        subfolder2 = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
    end
    merrillpath = 'D:/magnetosomes_thermal';
    groundstatepath = 'groundstates_bent_read';
    domainpath = 'D:/magnetosomes_thermal/groundstates_bent';
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
            filename = sprintf('%s_%gx_%gy_%gz_%gd_%dN_%db_%gT_single', crystal, x, y, z, d, N, b, T(n));
            filename2 = sprintf('%s_%gx_%gy_%gz_%gd_%dN_%db_%gT', crystal, x, y, z, d, N, b, T(n));
            domainsfile0b = sprintf('%s/%s_%s/%s.dat', domainpath, subfolder2,direction, filename2);
            newdomainsfile = sprintf('%s/%s/%s_%s/%s.dat', merrillpath, groundstatepath, subfolder, direction, filename);
            D = load(domainsfile0b);
            [r,~] = size(D);
            meshr = r/N;
            newfile = fopen(newdomainsfile,'w');
            for i = 1:10
                for j = 1 + (i-1)*meshr : meshr*i
                    if i<2
                        for m = 1:3
                            if  D(j, m)>=0
                                fprintf(newfile, '  %1.6f ', D(j, m));
                            else
                                fprintf(newfile, ' %1.6f ', D(j, m));
                            end
                        end
                        for m = 4:6
                            if  D(j, m)>=0
                                fprintf(newfile, ' %1.6f ', -D(j, m));
                            else
                                fprintf(newfile, '  %1.6f ', -D(j, m));
                            end
                        end
                        fprintf(newfile, '\n');
                    else
                        for m = 1:6
                            if  D(j, m)>=0
                                fprintf(newfile, '  %1.6f ', D(j, m));
                            else
                                fprintf(newfile, ' %1.6f ', D(j, m));
                            end
                        end
                        fprintf(newfile, '\n');
                    end
                end
            end
            fclose(newfile);
        end
    end
end