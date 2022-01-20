function E = BentLoadEnergyBarrierRandom3d(x, y, z, d, N, b,  r, T, a)
% BentLoadEnergyBarrierRandom(40, 40, 40, 8, 10, 300,20,5,'co')
    energy_path = 'D:/magnetosomes_thermal/energy_bent_random3d';
    subfolder = sprintf('3dco_%gx_%gy_%gz_%gd_%dN_%db_%dr', x, y, z, d, N, b,r);
    filename = sprintf('3dco_%gx_%gy_%gz_%gd_%dN_%db_%dr_%gT_%d.dat', x, y, z, d, N, b, r, T, a);
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