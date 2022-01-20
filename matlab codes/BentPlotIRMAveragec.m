function BentPlotIRMAveragec(H, M, x, y, z, d, N, b)

    mycolor = [0 0 0];
    
    handler = plot(H*1000, M, 'Color', mycolor); 
    set(handler, 'ButtonDownFcn', {@LineSelected, handler})

    grid on;

    xlabel('Field H (mT)');
    ylabel('Moment M'); 

    function LineSelected(ThisLine, EventData, Lines)
        set(ThisLine, 'LineWidth', 2.5);
        set(ThisLine, 'Color', [1 0 0]);
        set(Lines(Lines ~= ThisLine), 'LineWidth', 0.1);
        set(Lines(Lines ~= ThisLine), 'Color', mycolor);
        a = find(Lines == ThisLine); 
        coercivity = H(find(M(a,:)< 0, 1));  
        title(sprintf('x: %d, y: %d, z: %d, d: %d, N: %d, b: %d, Coercivity: %d mT, ...
                round(x(a)), round(y(a)), round(z(a)), ...
                round(d(a)), round(N(a)), round(b(a)),...
                round(coercivity*1000));
    end

end