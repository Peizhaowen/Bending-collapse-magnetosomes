function [M, H, Mr, Hcr, Mp,spec] = BentLoadOneIRM(x, y, z, d, N, b, a, Hinter)
    hys_path = 'D:/project_magnetosomes/IRM_bent'; 
    filename = sprintf('%s/IRM%dx_%dy_%dz_%dd_%dN_%db_%da.hyst', hys_path, x, y, z, d, N, b, a);
    
    fid = fopen(filename); 
	% 文件打开失败
    if fid == -1
        M = NaN; 
        H = NaN;
        Mr = 0;
        Hcr = 0;
        spec = NaN; 
        if nargin >= 8
            M = NaN(size(Hinter));
            H = NaN(size(Hinter));
            spec = NaN(size(Hinter));
        end
    else
	
%         textscan(fid, ' %s %s %s %s %s %s ', 1); 
%         C = textscan(fid, ' %f %f %f %f %f'); 
        C = textscan(fid, ' %f %f %f %f %f %f',84,'HeaderLines',2,'delimiter',',');
        fclose(fid); 
        M_IRMfile = C{2};
        Mp_IRMfile = C{3};
        H_IRMfile = C{1}; 
		l = length(M_IRMfile);
		H1 = H_IRMfile(find(H_IRMfile,(l/2)-2,'last'));
		H =[0;H1];
		M = M_IRMfile(find(H_IRMfile==0,(l/2)-1,'last'));
        Mp = Mp_IRMfile(find(H_IRMfile==0,(l/2)-1,'last'));
		%插�?
        if nargin >= 8 && length(H) > 5
            M_file = M; 
            H_file = H; 
            M = interp1(H, M, Hinter);
            Mp = interp1(H, Mp, Hinter);
            H = Hinter; 
        end
        spec = -M(1:end) - M(end:-1:1); 
        if H(end) >= 0 && ~isnan(M(end))&& H(find(M>0, 1))<0 &&  M(find(H>=0, 1))>0
            Hcr = H(find(M>0, 1));
            Mr = M(find(H>=0, 1));
        else 
            Mr = 0;
            Hcr = 0;
        end
    end
end