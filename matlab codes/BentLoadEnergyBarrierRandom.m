function E = BentLoadEnergyBarrierRandom(x, y, z, d, N, b, T, a, crystal)
% BentLoadEnergyBarrierRandom(40, 40, 40, 8, 10, 300,20,5,'co')
    energy_path = 'D:/magnetosomes_thermal/energy_bent_random';
    if crystal == 'c'
        subfolder = sprintf('%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
        filename = sprintf('%s_%dx_%dy_%dz_%dd_%dN_%db_%gT_%d.dat', crystal,x, y, z, d, N, b, T, a);
    else
        subfolder = sprintf('Cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
        filename = sprintf('%s_%dx_%dy_%dz_%dd_%dN_%db_%gT_%d.dat', crystal,x, y, z, d, N, b, T, a);
    end
    full_path = fullfile(energy_path, subfolder, filename);
    
    fid = fopen(full_path, 'r');
    if fid ~= -1
        C = textscan(fid, '%f %f');
        fclose(fid);
        E = C{2};
        num = C{1};
%         spl = [16/255 101/255 39/255];
%         plot(num,E*(10^18),'-o','color',spl,'linewidth',1.5,'MarkerFaceColor',spl);
%         hold on;
%         xlabel('NEB path index');
%         ylabel('Energy(10^{-18}Joule)');
%         axis([0 50 10 15]);
%         set(gca,'color','none');
%         set(gca,'Linewidth',1)
%         set(gca,'FontSize',15,'Fontname', 'Arial');
    else
        E = [];
    end
end