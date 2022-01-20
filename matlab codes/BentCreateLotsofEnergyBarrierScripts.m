% b = 0:30:300;
% for i = 1:11
%     BentCreateAllEnergyBarrierScripts(40, 40, 40, 3, 10, b(i),'c');
%     BentCreateAllEnergyBarrierScripts(40, 40, 40, 8, 10, b(i),'c');
%     BentCreateAllEnergyBarrierScripts(48, 40, 40, 8, 10, b(i),'c');
%     BentCreateAllEnergyBarrierScripts(40, 40, 40, 8, 10, b(i),'co');
% end
% b = 10:10:70;
% for i = 1:7
%     BentCreateAllEnergyBarrierScripts3d(40, 40, 40, 8, 10, b(i), 'co');
% end

b = 324;
BentCreateAllEnergyBarrierScripts(40, 40, 40, 3, 10, b,'c');
BentCreateAllEnergyBarrierScripts(40, 40, 40, 8, 10, b,'c');
BentCreateAllEnergyBarrierScripts(48, 40, 40, 8, 10, b,'c');
BentCreateAllEnergyBarrierScripts(40, 40, 40, 8, 10, b,'co');