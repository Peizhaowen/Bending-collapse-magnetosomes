b1 = 0:30:300;
for i = 1:11
    BentCreateAllEnergyBarrierScriptsSP(40, 40, 40, 3, 10, b1(i),'c');
    BentCreateAllEnergyBarrierScriptsSP(40, 40, 40, 8, 10, b1(i),'c');
    BentCreateAllEnergyBarrierScriptsSP(48, 40, 40, 8, 10, b1(i),'c');
    BentCreateAllEnergyBarrierScriptsSP(40, 40, 40, 8, 10, b1(i),'co');
end
b = 10:10:70;
for i = 1:7
    BentCreateAllEnergyBarrierScripts3dSP(40, 40, 40, 8, 10, b(i), 'co');
end