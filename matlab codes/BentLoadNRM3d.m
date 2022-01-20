function [M, Mp, Mvecs, Mvec] = BentLoadNRM3d(x, y, z, d, N, r)
    hys_path = 'D:/project_magnetosomes/NRM_bent3d'; 
    filename = sprintf('%s/minimize_3d%dx_%dy_%dz_%dd_%dN_%dr_1a.hyst', hys_path, x, y, z, d, N, r);
    
    fid = fopen(filename);
    if fid == -1
        M = NaN;
        Mvec = NaN; 
    else
        C = textscan(fid, ' %f %f %f %f %f %f',8,'HeaderLines',2,'delimiter',',');
        fclose(fid);
        M = C{2};
        Mp = C{3};
        Mvec = [C{4} C{5} C{6}];
        for i = 1:length(Mp)
            Mvecs(i) = sqrt(C{4}(i)^2+C{5}(i)^2+C{6}(i)^2);
        end
    end
end