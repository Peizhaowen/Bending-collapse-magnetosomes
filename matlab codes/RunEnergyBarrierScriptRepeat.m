b = 0;
T = [500:20:560 575];
T = 0;
% create script
% for num = 1:5
%      BentCreateMagnetosomeEnergyBarrierScriptRepeat(40, 40, 40, 8, 10, b, 'co', num)
% end
% %  T = [0:20:560 575]; 
%  for n = 1:length(T)
%      BentCreateMagnetosomeEnergyBarrierScriptRepeatBatch(40, 40, 40, 8, 10, b,'co', T(n));
%  end

% plot
for num = 1:5
    subfolder = sprintf('Cuboctahedron_%dx_%dy_%dz_%dd_%dN_%db', 40, 40, 40, 8, 10, b);
    Tname = sprintf('co_%gx_%gy_%gz_%gd_%dN_%db_%gT', 40, 40, 40, 8, 10, b, T);
    type = 'energy_bent';
    [selected_num, split_index] = BentCreateMagnetosomeEnergyBarrierRepeatSelectOneMin(subfolder, Tname, type);
    E = BentLoadandShowEnergyBarrierRepeat(40, 40, 40, 8, 10, b, T, 'co',num);
    E1(num) = max(E) - E(1);
    E2(num) = max(E) - E(end);
    dE(num) = (E1(num) + E2(num))/2;
    for n = 1:2
        BentLoadandShowEnergyBarrierSplitFirst(40, 40, 40, 8, 10, b, T, 'co', n, num);
    end
end

tau0 = 1e-9;
k = 1.38e-23;
t0 = tau0 * exp(dE./(k*(T+273.15)));
t = log10(t0);
