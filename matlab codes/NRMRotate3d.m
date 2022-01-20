function [p] = NRMRotate3d(x, y, z, d, N, b ,r)
    % NRMRotate3d(40, 40, 40, 8, 10, 30,1)
    domainpath = 'D:/magnetosomes_NRM/scripts/NRM_bent3d';
    domainsfile0b = sprintf('%s/3d%dx_%dy_%dz_%dd_%dN_0b_0_mT_1a.dat', domainpath, x, y, z, d, N);
    D = load(domainsfile0b);
    [row,~] = size(D);
    meshr = row/N;

    
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
            M_rot(j,:)= D(j,4:6)* Rot;
        end
    end
    
    for j = 1 + 9*meshr:meshr*10
        for m = 4:6
            M_rot(j,:) = D(j,m);
        end
    end
    
    sumr = sum(M_rot);
    sum0 = sum(D(:,4:6));
    mr = sumr*sumr';
    m0 = sum0*sum0';
    p = sqrt(mr/m0);
end