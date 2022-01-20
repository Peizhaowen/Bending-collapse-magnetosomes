function NRMCreateAllScriptFiles3d(x, y, z, d, N, r) 
    b =0:10:70;
    scriptfiles = cell(size(b));
    for a = 1:length(b)
        scriptfiles{a} =  NRMReadMinimize3d(x,y,z,d,N,r,b(a));
    end
    NRMCreateMerrillBatch3d(x, y, z, d, N, r, scriptfiles);
end