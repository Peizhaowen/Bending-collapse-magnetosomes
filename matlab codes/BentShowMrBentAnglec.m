function BentShowMrBentAnglec(x,y,z,d,N)
    b = [10:10:180];
    Hc = [];
    Mr = [];
    for i = 1:18
        H = linspace(-0.3, 0.3, 2000);     
        [~,  Hc(i), Mr(i)] = BentLoadAverageHysteresisc(x, y, z, d, N, b(i), H); 
        
    end
    plot(b,Mr,'r','linewidth',1);
    hold on;
    scatter(b,Mr,50,'r','linewidth',1.5);
    ylabel('Mr(Am^2)');
    xlabel('Bent angle(бу)');
    axis([0 200 0.1*10^-15 0.16*10^-15]);
    title(sprintf('Mr-Bent:%d-%d-%d-%d-%d',x,y,z,d,N));
end
