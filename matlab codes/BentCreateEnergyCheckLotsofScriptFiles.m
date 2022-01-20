b = [0:30:300 324]
for i = 1:12
    b(i)
    BentCreateEnergyCheckAllScriptFiles(40, 40, 40, 8, 10, b(i), 'co');
end