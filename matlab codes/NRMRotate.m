function [p] = NRMRotate(x, y, z, d, N, b )
    domainpath = 'D:/magnetosomes_NRM/scripts/NRM_bent';
    filename1 = sprintf('%dx_%dy_%dz_%dd_10N_0b_0_mT_1a',x,y,z,d);

    olddomainsfilenameb1 = sprintf('%s/%s.dat', domainpath, filename1);

    D1 = load(olddomainsfilenameb1);
    [r,~] = size(D1);
    meshr = r/10 ;
    aa = (b/(10-1))*pi/180;
    Drot =[];
    for i = 1:10
        ai = (-i+5.5)*aa;
        for j = 1 + (i-1)*meshr : meshr*i
%             Rot = eul2rotm([0,ai,0]);
            Drot(j,:) = D1(j,4:6)* roty(-ai);
        end
    end
    sumr = sum(Drot);
    sum0 = sum(D1(:,4:6));
    mr = sumr*sumr';
    m0 = sum0*sum0';
    p = sqrt(mr/m0);
end