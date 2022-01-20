
cend = [1,1,2];
cens = cend/sqrt(cend*cend');
% 计算方向向量地球坐标下的theta角和phi角
theta = pi/2 - acos(cens(3));
if cens(1)>=0
    phi = atan(cens(2)/cens(1));
else
    phi = atan(cens(2)/cens(1))+pi;
end
[1,1,1]./1.732*(roty(0.6154)*rotz(-0.7854))'*(roty(theta)*rotz(-phi))
Anis = (roty(0.6154)*rotz(-0.7854))'*(roty(theta)*rotz(-phi))
Anis