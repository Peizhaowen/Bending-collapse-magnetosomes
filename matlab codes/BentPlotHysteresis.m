function BentPlotHysteresis(H, M, Hc, Hsw1, Hsw2)
    if nargin < 3
        Hc = [];
        Hsw1 = [];
        Hsw2 = [];
    end

    mycolor = [0.5 0.5 0.5];
    
    [theta, phi, x, y, z] = LoadRandomAngles();
  
    handler = plot([H -H]*1000, [M -M], 'Color', mycolor,'Linewidth',0.25); 
    hold on;
    set(handler, 'ButtonDownFcn', {@LineSelected, handler})
    for n = 1:length(handler)
        ang = abs(theta(n)-90)/90;
        set(handler(n), 'Color', [ang 1-ang 0]); 
    end
    
    grid on;

    xlabel('Field H (mT)');
    ylabel('Moment M(Am^2)'); 
    set(gca,'Linewidth',1.5,'GridLineStyle', ':','YAxisLocation','origin','XAxisLocation','origin')
    set(gca,'color','none');
    function LineSelected(ThisLine, EventData, Lines)        
        for m = 1:length(Lines)
            ang = abs(theta(m)-90)/90;
            set(Lines(m), 'Color', [ang 1-ang 0]); 
        end
        set(ThisLine, 'LineWidth', 2.5);
        set(ThisLine, 'Color', [1 0 0]);
        set(Lines(Lines ~= ThisLine), 'LineWidth', 0.1);
        a = find(Lines == ThisLine); 
        
        title(sprintf('Angle: %d, Theta-90: %d Phi: %d  Coercivity: %d mT, Switching1: %d mT, Switching2: %d mT, Hx: %d, Hy: %d, Hz: %d', ...
                a, round(90-abs(theta(a)-90)), round(phi(a)), ...
                round(Hc(a)*1000), round(Hsw1(a)*1000),round(Hsw2(a)*1000),...
                round(100*x(a)), round(100*y(a)), round(100*z(a))));
    end
end