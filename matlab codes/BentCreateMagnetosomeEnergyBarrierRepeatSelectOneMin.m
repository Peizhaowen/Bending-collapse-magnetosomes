function [selected_num, split_index] = BentCreateMagnetosomeEnergyBarrierRepeatSelectOneMin(modelname, Tname, type)
% BentCreateMagnetosomeEnergyBarrierRepeatSelectOneMin(40, 40, 40, 8, 10, 0, 'co',0)
    min1 = 0;
    selected_num = 0;
    split_index = 0;
    for num = 1:5
        filename = sprintf('%s_%d', Tname, num);
        E = BentLoadEnergyBarrierRepeat(modelname, filename, type);
        Indmin = find(diff(sign(diff(E)))>0)+1;
        if length(Indmin) == 1
            selected_num = num;
            split_index = Indmin;
        end
    end
    if selected_num == 0
        for num = 1:5
            filename = sprintf('%s_%d', Tname, num);
            E = BentLoadEnergyBarrierRepeat(modelname, filename, type);
            Indmin = find(diff(sign(diff(E)))>0)+1;
            if length(Indmin) == 2
                if 15 > Indmin(1)
                    selected_num = num;
                    split_index = Indmin(2);
                end
            end
        end
    end
    if selected_num == 0
        for num = 1:5
            filename = sprintf('%s_%d', Tname, num);
            E = BentLoadEnergyBarrierRepeat(modelname, filename, type);
            Indmin = find(diff(sign(diff(E)))>0)+1;
            if length(Indmin) == 2
                selected_num = num;
                split_index = Indmin(1);
            end
        end
    end

end