function [M, Mp, Mvecs, Mvec] = BentLoadNRM(x, y, z, d, N)
    hys_path = 'D:/project_magnetosomes/NRM_bent'; 
    filename = sprintf('%s/minimize_%dx_%dy_%dz_%dd_%dN_1a.hyst', hys_path, x, y, z, d, N);
    
    fid = fopen(filename);
    if fid == -1
        M = NaN;
        Mvec = NaN; 
    else
        C = textscan(fid, ' %f %f %f %f %f %f',12,'HeaderLines',2,'delimiter',',');
        fclose(fid);
        M = C{2};
        Mp = C{3};
        Mvec = [C{4} C{5} C{6}];
        for i = 1:length(Mp)
            Mvecs(i) = sqrt(C{4}(i)^2+C{5}(i)^2+C{6}(i)^2);
        end
    end
end