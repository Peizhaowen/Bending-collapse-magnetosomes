function [E, Espmax] = BentLoadEnergyBarrier3dSP(x, y, z, d, N, b, r, T)
    energy_path = 'D:/project_magnetosomes/energy_bent3d_SP';
    subfolder = sprintf('3dco_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b, r);
    filename = sprintf('3dco_%dx_%dy_%dz_%dd_%dN_%db_%dr_%gT.dat', x, y, z, d, N, b, r, T);
    full_path = fullfile(energy_path, subfolder, filename)

    fid = fopen(full_path, 'r');
    if fid ~= -1
        C = importdata(full_path);
        D = C.data;
        fclose(fid);
        E = D(:,2);
        dET = max(E)-min(E);
        dEmax = 0;
        for i= 1:10
            E_sp = D(:,6*i+2);
            dE = max(E_sp)-min(E_sp);
            if dE > dEmax
                Espmax = E_sp;
                dEmax = dE;
            end
        end
    else
        E = [];
    end
end