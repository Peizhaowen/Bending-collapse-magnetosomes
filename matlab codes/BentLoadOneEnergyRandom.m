function [E0, Eend] = BentLoadOneEnergyRandom(x, y, z, d, N, b, a, T,crystal)
% BentLoadOneEnergyCheck(40, 40, 40, 8, 10, 324,1,20,'co')
    energy_path = 'D:/project_magnetosomes/energy_bent_random_all';
    if crystal == 'c'
        subfolder = sprintf('%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    else
        subfolder = sprintf('Cuboctahedron_%gx_%gy_%gz_%gd_%dN_%db', x, y, z, d, N, b);
    end
    
    filename = sprintf('%s_%gx_%gy_%gz_%gd_%dN_%db_%gT_%d.dat', crystal, x, y, z, d, N, b, T, a);
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