function [Maver, pDRM] = BentCalculateNRM3d(x, y, z, d, N)
%  BentCalculateNRM3d(40, 40, 40, 8, 10, 1)
    [theta_list, phi_list] = Load3dRandomAngles();
    if x == 100
        num =5;
    else
        num = 10;
    end
    Mrot = zeros(7,3);
    for r = 1:10
        [~,~,~,Mvec(1:8,1:3)] = BentLoadNRM3d(x, y, z, d, N, r);
        for a = 1:num
            for i = 1:7
                id = a+10*(r-1)+100*(i-1);
                theta = theta_list(id);
                phi = phi_list(id);
                angx = cos(theta/180*pi);
                angy = sin(theta/180*pi)*cos(phi/180*pi);
                angz = sin(theta/180*pi)*sin(phi/180*pi);
                direction = [angx angy angz];
                % Mrot = [1 0 0]*roty(theta/180*pi)*rotx((90-phi)/180*pi)
                Mrot(i,1:3)=Mrot(i,1:3)+Mvec(i+1,1:3)*roty(theta/180*pi)*rotx((90-phi)/180*pi);
            end
        end
    end
    Maver = Mrot./(num*10);
    for i = 1:7
        pDRM(i) = sqrt(Maver(i,1)^2+Maver(i,2)^2+Maver(i,3)^2);
    end
end