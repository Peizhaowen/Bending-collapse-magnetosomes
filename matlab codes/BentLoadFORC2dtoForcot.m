function BentLoadFORC2dtoForcot(x, y, z, d, N, b)
    % BentLoadFORC2dtoForcot(40, 40, 40, 8, 10, 0)
    hys_path = 'D:/project_magnetosomes/hysteresis_bent_Final_FORC';
    num=200;
    name = sprintf('2d_FORC_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    filename = sprintf('%s/final_%s.txt', hys_path, name);
    data=importdata(filename);
    forcotname =  sprintf('%s/forcot_%s.csv', hys_path, name);
    fid=fopen(forcotname,'w');
    for i = 0:num
        id = sum([0:1:i+1]);
        if i > 0
            for j = 0:i-1
                fprintf(fid,'NaN, NaN,');
            end
        end
        for j = i:num
            if j == num
                fprintf(fid,'%f, %f',data(id,1), data(id,2));
            else
                fprintf(fid,'%f, %f,',data(id,1),data(id,2));
            end
            id = id+j+1;
        end
        fprintf(fid,'\n');
    end
    fclose all;
end