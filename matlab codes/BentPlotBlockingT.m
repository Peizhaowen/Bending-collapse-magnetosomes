function BentPlotBlockingT(x, y, z, d, N)

%BentPlotBlockingT(40, 40, 40, 8, 10)
%BentPlotBlockingT(48, 40, 40, 3, 10)

    b = [0:30:180];
    Tb =[];
    
    for i= 1:7
        Tb(i) = BentCalculateBlockingT(x, y, z, d, N, b(i));
    end
    
    f1 = plot(b, Tb, 'o-');
    ylabel('Blocking Temperature(¡æ)');
    xlabel('Bent angle(¡ã)');
    axis([0 180 500 600]);
    l1= legend(f1,'Cube-40-40-40-8-10');
    set(l1,'Fontsize',15);
    hold on;
end