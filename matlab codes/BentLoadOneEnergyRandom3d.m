function [E0, Eend] = BentLoadOneEnergyRandom3d(x, y, z, d, N, b, r, a, T,crystal)
    % BentLoadOneEnergyCheck3d(40, 40, 40, 8, 10, 70,1,1,20,'co')
    energy_path = 'D:/project_magnetosomes/energy_bent_random3d_all';
    subfolder = sprintf('3dco_%gx_%gy_%gz_%gd_%dN_%db_%dr', x, y, z, d, N, b,r);
    filename = sprintf('3d%s_%gx_%gy_%gz_%gd_%dN_%db_%dr_%gT_%d.dat', crystal, x, y, z, d, N, b, r, T, a);
    full_path = fullfile(energy_path, subfolder, filename);

    fid = fopen(full_path, 'r');
    if fid ~= -1
        C = textscan(fid, '%f %f');
        fclose(fid);
        E = C{2};
        E0 = E(1);
        Eend = E(3);
        num = C{1};
    else
        E = [];
    end
end