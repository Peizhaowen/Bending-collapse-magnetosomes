function [E, Espmax] = BentLoadEnergyBarrierSP(x, y, z, d, N, b, T,crystal)
% BentLoadEnergyBarrierSP(40, 40, 40, 3, 10, 0, 0,'c')
    energy_path = 'D:/project_magnetosomes/energy_bent_SP';
    if crystal == 'c'
        subfolder = sprintf('%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
        filename = sprintf('%s_%dx_%dy_%dz_%dd_%dN_%db_%gT.dat', crystal,x, y, z, d, N, b, T);
    else
        subfolder = sprintf('Cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
        filename = sprintf('%s_%dx_%dy_%dz_%dd_%dN_%db_%gT.dat', crystal,x, y, z, d, N, b, T);
    end
    full_path = fullfile(energy_path, subfolder, filename);
    
    fid = fopen(full_path, 'r');
    if fid ~= -1
        C = importdata(full_path);
        D = C.data;
        fclose(fid);
        E = D(:,2);
        dEmax = 0;
        for i= 1:10
            E_sp = D(:,6*i+2);
            i
            dE = max(E_sp)-min(E_sp)
            if dE > dEmax
               Espmax = E_sp;
               dEmax = dE;
            end
        end
    else
        E = [];
    end
end