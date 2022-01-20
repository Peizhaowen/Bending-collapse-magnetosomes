% function BentLoadEnergyBarrier3d(x, y, z, d, N, b, r, T)
function E = BentLoadEnergyBarrier3d(x, y, z, d, N, b, r, T)
% BentLoadEnergyBarrier3d(40, 40, 40, 8, 10, 70,5, 20)
    energy_path = 'D:/project_magnetosomes/energy_bent3d'; 
    subfolder = sprintf('3dco_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b, r);
    filename = sprintf('3dco_%dx_%dy_%dz_%dd_%dN_%db_%dr_%gT.dat', x, y, z, d, N, b, r, T);
    full_path = fullfile(energy_path, subfolder, filename);
    
    fid = fopen(full_path, 'r');
    if fid ~= -1
        C = textscan(fid, '%f %f');
        fclose(fid);
        E = C{2};
        num = C{1};
%         spl = [16/255 101/255 39/255];
%         plot(num,E*(10^18),'-o','color',spl,'linewidth',1.5,'MarkerFaceColor',spl);
%         % axis([0 50 13 16]);
%         xlabel('NEB path index');
%         ylabel('Energy(10^{-18}Joule)');
%         set(gca,'color','none');
%         set(gca,'Linewidth',1)
%         set(gca,'FontSize',15,'Fontname', 'Arial');
    else
        E = [];
    end
end