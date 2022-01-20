function BentShowHcBentAngle3d(x,y,z,d,N,r)
    b = [0:10:90];
    Hc = [];
    Mr = [];
    for i = 1:10
        H = linspace(-0.3, 0.3, 2000);     
        [~,  Hc(i), Mr(i)] = BentLoadAverageHysteresis3d(x, y, z, d, N, b(i), r, H); 
        
    end
    plot(b,Hc,'r','linewidth',2);
    hold on;
    scatter(b,Hc,50,'r','linewidth',2.5);
    ylabel('Hc(mT)');
    xlabel('Bent angle(бу)');
    set(gca,'Linewidth',1.5,'GridLineStyle', ':','YAxisLocation','origin','XAxisLocation','origin');
    axis([0 90 0 0.04]);
    %title(sprintf('Hc-Bent:%d-%d-%d-%d-%d',x,y,z,d,N));
    set(gca,'color','none');
    set(gca,'FontSize',20,'Fontname', 'Times New Roman');
end
