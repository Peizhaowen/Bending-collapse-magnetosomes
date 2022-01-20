function BentShowHysteresisAngle(x, y, z, d, N,a)

% BentShowHysteresisAngle(40, 40, 40, 8, 10, 62)
    H = linspace(-0.3, 0.3, 2000);   
    b = [0:10:180];
    for i = 1:19 
        [~, ~,~, ~,~,Mr(i), Hc(i), Hsw1,Hsw2,~] = BentLoadOneHysteresis(x, y, z, d, N, b(i), a, H);
    end
%     plot(b,-Mr);
    plot(b,Hc);
    hold on;
end