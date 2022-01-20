function [Maver, pDRM] = BentCalculateNRM(x, y, z, d, N)
%  BentCalculateNRM(40, 40, 40, 3, 10)
    [~,~,~,Mvec(1:12,1:3)] = BentLoadNRM(x, y, z, d, N);
    [theta_list, phi_list] = LoadRandomAngles();
    if x == 100
        num =25;
    else
        num = 100;
    end
    Mrot = zeros(12,3);
    for a = 1:num
        theta = theta_list(a);
        phi = phi_list(a);
        angx = cos(theta/180*pi);
        angy = sin(theta/180*pi)*cos(phi/180*pi);
        angz = sin(theta/180*pi)*sin(phi/180*pi);
        direction = [angx angy angz];
%         Mrot = [1 0 0]*roty(theta/180*pi)*rotx((90-phi)/180*pi)
        for i = 1:12
            Mrot(i,1:3)=Mrot(i,1:3)+Mvec(i,1:3)*roty(theta/180*pi)*rotx((90-phi)/180*pi);
        end
    end
    Maver = Mrot./num;
    for i = 1:12
        pDRM(i) = sqrt(Maver(i,1)^2+Maver(i,2)^2+Maver(i,3)^2);
    end
end