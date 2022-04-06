function E = BentLoadandShowEnergyBarrierSplitSecond3d(x, y, z, d, N, b, r, T,crystal,n,num)
    energy_path = 'D:/magnetosomes_thermal/energy_bent3d'; 
    subfolder = sprintf('3dco_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b, r);    
    Tname = sprintf('3d%s_%gx_%gy_%gz_%gd_%dN_%db_%dr_%gT', crystal, x, y, z, d, N, b, r, T);
    type = 'energy_bent3d';
    [selected_num, split_index] = BentCreateMagnetosomeEnergyBarrierRepeatSelectOneMin(subfolder, Tname, type);
    Tname21 = sprintf('%s_%d_%d_1', Tname,selected_num, split_index);
    [selected_num21, split_index21] = BentCreateMagnetosomeEnergyBarrierRepeatSelectOneMin(subfolder, Tname21, type);
    filename = sprintf('%s_%d_%d_%d_%d.dat', Tname21, selected_num21, split_index21, n, num);
    full_path = fullfile(energy_path, subfolder, filename);
    fid = fopen(full_path, 'r');
    if fid ~= -1
        C = textscan(fid, '%f %f');
        fclose(fid);
        E = C{2};
        index = C{1};
        mkf = [1 1 1];
%         
        % plot start
        spl = [128/255 0/255 128/255];
        % plot(index,E*(10^18),'-o','color',spl,'linewidth',0.5,'MarkerFaceColor',spl);
        if n == 1
            new_end = split_index21*split_index/50;
            plot([1:(new_end-1)/49:new_end],E*(10^18),'-o','color',spl,'linewidth',1,'MarkerFaceColor',mkf);
        end
        spl = [128/255 64/255 0/255];
        if n == 2
            new_end = split_index21*split_index/50;
            plot([new_end:(split_index-new_end)/49:split_index],E*(10^18),'-o','color',spl,'linewidth',1,'MarkerFaceColor',mkf);
        end
        hold on;
        xlabel('NEB path index');
        ylabel('Energy(10^{-18}Joule)');
        set(gca,'color','none');
        set(gca,'Linewidth',1)
        set(gca,'FontSize',15,'Fontname', 'Arial');
        % plot end
        
    else
        E = [];
    end
end