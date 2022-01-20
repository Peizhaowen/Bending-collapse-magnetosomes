function NRMCreateAllScriptFiles2d(x, y, z, d, N) 
    b =[0:30:300, 324];
    scriptfiles = cell(size(b));
    for a = 1:length(b)
        scriptfiles{a} =  NRMReadMinimize2d(x,y,z,d,N,b(a));
    end
    NRMCreateMerrillBatch2d(x, y, z, d, N, scriptfiles);
end