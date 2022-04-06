function E = BentLoadandShowEnergyBarrierRepeat(x, y, z, d, N, b, T,crystal,num)
% BentLoadandShowEnergyBarrierRepeat(40, 40, 40, 8, 10, 0, 0,'co',4)
    energy_path = 'D:/magnetosomes_thermal/energy_bent';
    if crystal == 'c'
        subfolder = sprintf('%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    else
        subfolder = sprintf('Cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    end
    filename = sprintf('%s_%dx_%dy_%dz_%dd_%dN_%db_%gT_%d.dat', crystal,x, y, z, d, N, b, T, num);
    full_path = fullfile(energy_path, subfolder, filename);
    fid = fopen(full_path, 'r');
    if fid ~= -1
        C = textscan(fid, '%f %f');
        fclose(fid);
        E = C{2};
        index = C{1};
        
%         % plot start
%         spl = [26/255 51/255 189/255];
%         mkf = [1 1 1];
%         plot(index,E*(10^18),'-o','color',spl,'linewidth',1.5,'MarkerFaceColor',mkf);
%         % plot(index,E*(10^18),'-o','linewidth',1.5);
%         hold on;
%         xlabel('NEB path index');
%         ylabel('Energy(10^{-18}Joule)');
%         set(gca,'color','none');
%         set(gca,'Linewidth',1)
%         set(gca,'FontSize',15,'Fontname', 'Arial');
%         % plot end
        
    else
        E = [];
    end
end