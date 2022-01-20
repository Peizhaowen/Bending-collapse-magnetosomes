function BentCreateIRMAllScriptFiles(x, y, z, d, N, b) 
    [theta, phi] = LoadRandomAngles();
        if x == 100
        num =25;
    else
        num = 100;
    end
    scriptfiles = cell(num);
    for a = 1:num
        scriptfiles{a} = BentCreateIRMScript(x, y, z, d, N, b,a, theta(a), phi(a));
    end
    BentCreateIRMMerrillBatch(x, y, z, d, N, b,scriptfiles);
end