function [p] = Bent3dGetFORCPosition(x,y,z,d,N,b,r,randa,bzr,bxr,xr,yr,zr)
    p = zeros(10,3);
    if b==0
        for i = 1:10
             p(i,1) = p(i,1) + (x+d)*(i-5.5)/1000;
        end
    else
        for i = 1:N-1
            id = (r-1) * 9 + i;
            rz = randa(id)*pi/180;
            for k =1:i
                if b < 45
                    p(k,1) = p(k,1) + (d+x*(1+(1/cos((20+b*20/45)*pi/180)-1)))/1000;
                else
                    p(k,1) = p(k,1) + (d+x*(1+(1/cos(30*pi/180)-1)))/1000;
                end
            end
            for j = 1:i
                p(j,:) = p(j,:)*rotz(-b*pi/180);
                p(j,:) = p(j,:)*rotx(-rz);
            end
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