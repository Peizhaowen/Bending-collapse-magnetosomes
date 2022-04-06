b = 70;
r = 1;
% T = [0:100:300];
% T = [340:20:380];
T = 360;

% % create script
% randpath = sprintf('D:/magnetosomes/randangle/randangle.csv');
% fid = fopen(randpath);
% Rand = textscan(fid, ' %f','delimiter',',');
% rand = Rand{1};
% fclose(fid);
% for num = 1:5
%     BentCreateMagnetosomeEnergyBarrierScript3dRepeat(40, 40,40,8,10,b,r,'co',rand,num);
% end
% for n = 1:length(T)
%     BentCreateMagnetosomeEnergyBarrierScript3dRepeatBatch(40, 40, 40, 8, 10, b,r,'co',T(n));
% end

% for num = 1:5
%     BentLoadandShowEnergyBarrierRepeat3d(40, 40, 40, 8, 10, b, r, T, 'co',num);
% end


% show split
for num = 1:5
    subfolder = sprintf('3dco_40x_40y_40z_8d_10N_%db_%dr', b, r);
    Tname = sprintf('%s_%gT', subfolder, T);
    type = 'energy_bent3d';
    [selected_num, split_index] = BentCreateMagnetosomeEnergyBarrierRepeatSelectOneMin(subfolder, Tname, type);
    Tname21 = sprintf('%s_%d_%d_1', Tname,selected_num, split_index);
    [selected_num21, split_index21] = BentCreateMagnetosomeEnergyBarrierRepeatSelectOneMin(subfolder, Tname21, type);
    E = BentLoadandShowEnergyBarrierRepeat3d(40, 40, 40, 8, 10, b, r, T, 'co',num);
    E1(num) = max(E) - E(1);
    E2(num) = max(E) - E(end);
    dE(num) = (E1(num) + E2(num))/2;
    for n = 1:2
        BentLoadandShowEnergyBarrierSplitFirst3d(40, 40, 40, 8, 10, b, r, T, 'co', n, num);
        BentLoadandShowEnergyBarrierSplitSecond3d(40, 40, 40, 8, 10, b, r, T, 'co', n, num);
    end
end

tau0 = 1e-9;
k = 1.38e-23;
t0 = tau0 * exp( dE./(k*(T+273.15)));
t = log10(t0)