function BentShowHcrBentAngle(x,y,z,d,N)
    b = [0:10:60 80:10:110 130:10:180];
    Hcr = [];
    Mr = [];
    for i = 1:17
        H = linspace(-0.3, 0, 1000);     
        [~,  Hcr(i), Mr(i)] = BentLoadAverageIRM(x, y, z, d, N, b(i), H); 
       
    end
    plot(b,-Hcr,'b','linewidth',1);
    hold on;
    scatter(b,-Hcr,50,'b','linewidth',1.5);
    ylabel('Hcr(mT)');
    xlabel('Bent angle(бу)');
    title(sprintf('Hcr-Bent:%d-%d-%d-%d-%d',x,y,z,d,N));
end
