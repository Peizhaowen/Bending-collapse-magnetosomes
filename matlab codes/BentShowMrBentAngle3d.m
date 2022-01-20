function BentShowMrBentAngle3d(x,y,z,d,N,r)
    b = [0:10:90];
    Hc = [];
    Mr = [];
    for i = 1:10
        H = linspace(-0.3, 0.3, 2000);     
        [~,  Hc(i), Mr(i)] = BentLoadAverageHysteresis3d(x, y, z, d, N, b(i), r, H); 
    end
    plot(b,Mr,'r','linewidth',2);
    hold on;
    scatter(b,Mr,50,'r','linewidth',2.5);
    ylabel('Mr(Am^2)');
    xlabel('Bent angle(бу)');
    axis([0 90 0.05*10^-15 0.25*10^-15]);
    set(gca,'Linewidth',1.5,'GridLineStyle', ':','YAxisLocation','origin','XAxisLocation','origin');
    %title(sprintf('Mr-Bent:%d-%d-%d-%d-%d',x,y,z,d,N));
    set(gca,'color','none');
    set(gca,'FontSize',20,'Fontname', 'Times New Roman');
end
