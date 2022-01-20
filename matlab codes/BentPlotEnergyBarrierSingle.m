function E = BentPlotEnergyBarrierSingle(x, y, z, d, N, b, T,crystal)
% BentPlotEnergyBarrierSingle(40, 40, 40, 3, 10, 0, 0, 'c')
    col = linspace(0, 1, length(T));
    
    for n = 1:length(T)
        E = BentLoadEnergyBarrierSingle(x, y, z, d, N, b, T(n),crystal);
        plot(E-min(E), '-', 'DisplayName', num2str(T(n)), 'Color', [col(n) 0 1-col(n)]);
        hold on
    end
%     hold off
    legend('location', 'best');
end