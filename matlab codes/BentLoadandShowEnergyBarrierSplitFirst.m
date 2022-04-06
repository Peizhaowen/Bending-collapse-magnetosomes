function E = BentLoadandShowEnergyBarrierSplitFirst(x, y, z, d, N, b, T,crystal,n,num)
    energy_path = 'D:/magnetosomes_thermal/energy_bent';
    if crystal == 'c'
        subfolder = sprintf('%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    else
        subfolder = sprintf('Cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    end
    Tname = sprintf('%s_%gx_%gy_%gz_%gd_%dN_%db_%gT', crystal, x, y, z, d, N, b, T);
    type = 'energy_bent';
    [selected_num, split_index] = BentCreateMagnetosomeEnergyBarrierRepeatSelectOneMin(subfolder, Tname, type);
    filename = sprintf('%s_%dx_%dy_%dz_%dd_%dN_%db_%gT_%d_%d_%d_%d.dat', crystal,x, y, z, d, N, b, T, selected_num, split_index, n, num);
    full_path = fullfile(energy_path, subfolder, filename);
    fid = fopen(full_path, 'r');
    if fid ~= -1
        C = textscan(fid, '%f %f');
        fclose(fid);
        E = C{2};
        index = C{1};
        mkf = [1 1 1];
        
        % plot start
        spl = [16/255 101/255 39/255];
        % plot(index,E*(10^18),'-o','color',spl,'linewidth',0.5,'MarkerFaceColor',spl);
        if n == 1
            plot([1:(split_index-1)/49:split_index],E*(10^18),'-o','color',spl,'linewidth',1,'MarkerFaceColor',mkf);
        end
        spl = [26/255 101/255 190/255];
        if n == 2
            plot([split_index:(50-split_index)/49:50],E*(10^18),'-o','color',spl,'linewidth',1,'MarkerFaceColor',mkf);
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