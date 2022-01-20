function BentShowAngle(x, y, z, d, N, b)     
    H = linspace(-0.3, 0.3, 2000);
    [theta, phi, ~, ~, ~] = LoadRandomAngles();
    Mr =[];
    Mpr=[];
    Hc=[];
    for a = 1:100
        [~,~, ~, ~, Mr, Mpr, Hc(a), ~, ~, ~] = BentLoadOneHysteresis(x, y, z, d, N, b, a, H); 
    end
%     plot(theta,Hc,'g','linewidth',1);
%     hold on;
    scatter(theta,Hc,50,'k','linewidth',1.5);
    ylabel('Hc(mT)');
    xlabel('Field angle(бу)');
%     axis([0 200 0.1*10^-15 0.16*10^-15]);
    title(sprintf('Hc-Angle:%d-%d-%d-%d-%d-%d',x,y,z,d,N,b));
end