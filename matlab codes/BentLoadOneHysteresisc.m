function [M, Mp, H, Mvec, Mr, Mpr, Hc, Hsw1, Hsw2, spec] = BentLoadOneHysteresisc(x, y, z, d, N, b, a, Hinter)
%    hys_path = 'D:/project_magnetosomes/hysteresis_bent_Cuboctahedron'; 
     hys_path = 'D:/project_magnetosomes/hysteresis_bent_Cuboctahedron';
    filename = sprintf('%s/Cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db_%da.hyst', hys_path, x, y, z, d, N, b, a);
    
    fid = fopen(filename); 

    if fid == -1
        M = NaN; 
        H = NaN; 
        Mvec = NaN; 
        Mr = NaN;
        Hc = NaN;
        Hsw = NaN;
        Hsw_file1 = NaN;
        Hsw_file2 = NaN;
        spec = NaN; 
        if nargin >= 8
            M = NaN(size(Hinter));
            H = NaN(size(Hinter));
            Mvec = NaN(length(Hinter), 3);
            spec = NaN(size(Hinter));
        end
    else
        C = textscan(fid, ' %f %f %f %f %f %f',55,'HeaderLines',2,'delimiter',',');
        fclose(fid); 
        M = C{2};
        Mp = C{3};
        H = C{1}; 
		
        Mvec = [C{4} C{5} C{6}]; 
        
        if nargin >= 8 && length(H) > 5
            Mvec_file = Mvec; 
            Mvec1 = interp1(H, Mvec(:,1), Hinter(:));
            Mvec2 = interp1(H, Mvec(:,2), Hinter(:));
            Mvec3 = interp1(H, Mvec(:,3), Hinter(:)); 
            Mvec = [Mvec1 Mvec2 Mvec3]; 
            M_file = M; 
            H_file = H; 
            M = interp1(H, M, Hinter);
            Mp = interp1(H, Mp, Hinter);
            H = Hinter; 
        end
        
        spec = -M(1:end) - M(end:-1:1); 
        if H(end) >= 0.3 && ~isnan(M(end))
            Hc = H(find(M>0, 1)); 
            [Hsw1,Hsw2] = BentCalculateSwitchingField(M_file,H_file);
            Mr = M(find(H>=0, 1)); 
            Mpr = Mp(find(H>=0, 1));
        else 
            Mr = NaN;
            Hc = NaN;
            Hsw1 = NaN;
            Hsw2 = NaN;
        
        end
    end
end