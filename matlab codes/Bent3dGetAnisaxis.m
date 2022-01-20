function Anis = Bent3dGetAnisaxis(x,y,z,d,N,b,r,num,randa)
    % Bent3dGetAnisaxis(40,40,40,8,10,10,1,1)
    cen = Bent3dGetPosition(x,y,z,d,N,b,r,randa);
    % point1 -> point 2
    cend = cen(num,:)- cen(num+1,:);
    cens = cend/sqrt(cend*cend');
    % calculate theta and phi in spherical coordinates
    theta = pi/2 - acos(cens(3));
    if cens(1)>=0
        phi = atan(cens(2)/cens(1));
    else
        phi = atan(cens(2)/cens(1))+pi;
    end
    [1,1,1]./1.732*(roty(0.6154)*rotz(-0.7854))'*(roty(theta)*rotz(-phi));
    Anis = (roty(0.6154)*rotz(-0.7854))'*(roty(theta)*rotz(-phi));
end
