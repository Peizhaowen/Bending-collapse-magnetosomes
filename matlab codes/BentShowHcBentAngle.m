function BentShowHcBentAngle(x,y,z,d,N)
    b = [0:10:180];
    Hc = [];
    Mr = [];
    for i = 1:19
        H = linspace(-0.3, 0.3, 2000);     
        [~,  Hc(i), Mr(i)] = BentLoadAverageHysteresis(x, y, z, d, N, b(i), H); 
        
    end
    plot(b,Hc,'b','linewidth',1);
    hold on;
    scatter(b,Hc,50,'b','linewidth',1.5);
    ylabel('Hc(mT)');
    xlabel('Bent angle(бу)');
    
    axis([0 200 0.015 0.055]);
    title(sprintf('Hc-Bent:%d-%d-%d-%d-%d',x,y,z,d,N));
end
