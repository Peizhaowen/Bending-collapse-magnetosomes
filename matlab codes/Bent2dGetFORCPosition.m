function [p] = Bent2dGetFORCPosition(x,y,z,d,N,b,bzr,bxr,xr,yr,zr)
    % rot()里面要加负号才正确
    p = zeros(10,3);
    if b==0
        for i = 1:10
             p(i,1) = p(i,1) + (x+d)*(i-5.5)/1000;
        end
    else
        at = (b/(N-1))*pi/180;
        R = (((d/2)/cos(at/2)) + (x/2))/(tan(at/2));
        r1 = (-R-y/2)*0.001;
        
        for i = 1:10
            p(i,3) = p(i,3) + r1;
            p(i,:) = p(i,:)*roty(-(-i+5.5)*at);
        end
        
        r2 = (R + y/2)*0.001;
        for j = 1:10
            p(j,3) = p(j,3) + r2;
        end
    end
    
    for j = 1:10
        p(j,:) = p(j,:)*rotz(-bzr*pi/180);
        p(j,:) = p(j,:)*rotx(-bxr*pi/180);
    end
    
    for j = 1:10
         p(j,:) = p(j,:) + [xr yr zr];
    end
end