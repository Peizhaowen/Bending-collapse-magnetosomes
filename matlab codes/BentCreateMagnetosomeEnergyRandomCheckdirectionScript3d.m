function calculate_list = BentCreateMagnetosomeEnergyRandomCheckdirectionScript3d(x, y, z, d, N, b, r)
    % BentCreateMagnetosomeEnergyRandomCheckdirectionScript(40, 40, 40, 8, 10, 0, 'co')
    T = 20;
    % load hyst files
    merrillpath = 'D:/magnetosomes_thermal'; 
    hys_path = 'hysteresis_groundstate_bent_random3d';
    filename0 = sprintf('3dco_%gx_%gy_%gz_%gd_%dN_%db_%dr_%gT', x, y, z, d, N, b,r,T);
    filename = sprintf('%s/%s/%s.hyst',  merrillpath, hys_path,filename0);
    fid = fopen(filename);
    C = textscan(fid, ' %f %f %f %f %f %f',100,'HeaderLines',2,'delimiter',',');
    fclose(fid);
    Mvec = [C{4} C{5} C{6}];

    % load pDRM file
    hys_path = 'D:/project_magnetosomes/NRM_bent3d';
    filename = sprintf('%s/minimize_3d%dx_%dy_%dz_%dd_%dN_%dr_1a.hyst', hys_path, x, y, z, d, N, r);
    fid = fopen(filename);
    C = textscan(fid, ' %f %f %f %f %f %f',8,'HeaderLines',2,'delimiter',',');
    fclose(fid);
    Mvec_pDRM = [C{4} C{5} C{6}]; 
    Mvec_pDRM_n = [-C{4} -C{5} -C{6}]; 
    existing_list = [Mvec_pDRM(ceil(b/10)+1,:)];
    calculate_list = [];
    % check every state
    for a = 1:100
        moment = Mvec(a,:);
        num = 0;
        for i = 1:length(existing_list(:,1))
            distance_n = sqrt((existing_list(i, 1)-moment(1))^2+...
                (existing_list(i, 2)-moment(2))^2+...
                (existing_list(i, 3)-moment(3))^2);
            distance_p = sqrt((-existing_list(i, 1)-moment(1))^2+...
                (-existing_list(i, 2)-moment(2))^2+...
                (-existing_list(i, 3)-moment(3))^2);
            if distance_n > 0.1 & distance_p > 0.1
               num = num + 1;
            end
        end
        if num > length(existing_list(:,1))-1
            existing_list(length(existing_list(:,1))+1,:) = moment;
            calculate_list = [calculate_list a];
        end
    end
end