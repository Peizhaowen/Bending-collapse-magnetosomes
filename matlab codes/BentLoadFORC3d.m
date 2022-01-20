function BentLoadFORC3d(x, y, z, d, N, b)
    % BentLoadFORC3d(40, 40, 40, 8, 10, 30)
    hys_path = 'D:/project_magnetosomes/hysteresis_bent3d_single_FORC';

    q=0;
    name = sprintf('3d_FORC_%dx_%dy_%dz_%dd_%dN_%db', x, y, z, d, N, b);
    for r=1:20
        for a=1:20
            id = a+20*(r-1);
            for m = 200:-2:-200
                filename = sprintf('%s/%s_%dr_%da_%dmT.hyst', hys_path, name, r, a, m)
                data=importdata(filename);
                A=data.data;
                l=length(A(:,3));
                total(q+1:q+l,id)=A(:,3);
                q=sum(sum(total(:,id)~=0));
            end
            q=0;
        end
    end
    total_filename =  sprintf('%s/total_%s.txt', hys_path, name);
    dlmwrite(total_filename,total,'delimiter',' ');
    final_filename =  sprintf('%s/final_%s.txt', hys_path, name);
    fid=fopen(final_filename,'w');
    data=importdata(total_filename);
    total1=sum(data,2)./400;
    field2=zeros();
    for n=0.2:-0.002:-0.2
        field=[n:0.002:0.2]';
        field2=[field2;field];
    end
    k1=1;
    k2=1;
    k3=1;
    while(k2<=(length(field2)-1))
        for mm=k1:k2
            fprintf(fid,'%f,%f\r\n',field2(mm+1),total1(mm));
        end
        k1=k2+1;
        k2=k1+k3;
        k3=k3+1;
        fprintf(fid,'\r\n');
    end
    fprintf(fid,'END');
    fclose all;
end