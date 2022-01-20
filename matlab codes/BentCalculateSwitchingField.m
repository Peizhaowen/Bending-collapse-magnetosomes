function [Hsw1,Hsw2] = BentCalculateSwitchingField(M_file,H_file)
    d = [];
    for i = 1:length(M_file)-1
        d(i) = abs((M_file(i+1)-M_file(i))/((H_file(i+1)-H_file(i))*1000));
    end
    [maxd1,maxp1] = max(d);
    d(maxp1) = min(d);
    [maxd2,maxp2] = max(d);
    Hsw11 = H_file(maxp1);
    Hsw12 = H_file(maxp1 + 1);
    Hsw1 = (Hsw11 + Hsw12)/2;
    %if maxd2 > 0.01 && maxd2 > 4 * d(maxp2-1)
    if maxd2 > 4 * d(maxp2-1)
        Hsw21 = H_file(maxp2);
        Hsw22 = H_file(maxp2 + 1);
        Hsw2 = (Hsw21 + Hsw22)/2;
    else
        Hsw2 = NaN;
    end
end


