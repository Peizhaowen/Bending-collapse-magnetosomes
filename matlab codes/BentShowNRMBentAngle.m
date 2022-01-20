function BentShowNRMBentAngle(x,y,z,d,N)
    b = [0:10:180];
    Mr = [];
    [Mr,~] = BentLoadNRM(x, y, z, d, N);
    for i = 1:19
        mr(i)=Mr(i,1);
    end
    plot(b,-mr,'b','linewidth',1);
    hold on;
    scatter(b,-mr,50,'b','linewidth',1.5);
    ylabel('NRM(Am^2)');
    xlabel('Bent angle(бу)');

    title(sprintf('NRM-Bent'));
end
