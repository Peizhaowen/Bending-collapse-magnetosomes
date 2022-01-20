function NRMDataRotate2dc(x,y,z,d,N,b)
%  NRMDataRotate2dc(100,100,100,3,10,30)
    domainpath = 'D:/magnetosomes_NRM/scripts/NRM_bent';
    filename = sprintf('Cuboctahedron_%dx_%dy_%dz_%dd_%dN', x, y, z, d, N);
    filename0 = sprintf('%dx_%dy_%dz_%dd_%dN', x, y, z, d, N);
    domainsfile0b = sprintf('%s/co_%s_0b_20T.dat', domainpath, filename0);
    [~,~,~] = mkdir(sprintf('%s/%s', domainpath, filename));
    newdomainsfile = sprintf('%s/%s/%s_%db_0_mT_1a.dat', domainpath, filename, filename,b);
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