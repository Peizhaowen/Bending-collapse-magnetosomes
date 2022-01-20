function [Anis,cen] = Bent2dGetFORCAnisaxis(x,y,z,d,N,b,num,bzr,bxr,xr,yr,zr)
    cen = Bent2dGetFORCPosition(x,y,z,d,N,b,bzr,bxr,xr,yr,zr);
    cend = cen(num,:)- cen(num+1,:);
    cens = cend/sqrt(cend*cend');
    theta = pi/2 - acos(cens(3));
    if cens(1)>=0
        phi = atan(cens(2)/cens(1));
    else
        phi = atan(cens(2)/cens(1))+pi;
    end
    [1,1,1]./1.732*(roty(0.6154)*rotz(-0.7854))'*(roty(theta)*rotz(-phi));
    Anis = (roty(0.6154)*rotz(-0.7854))'*(roty(theta)*rotz(-phi));
end
