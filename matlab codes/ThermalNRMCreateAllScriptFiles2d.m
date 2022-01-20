function ThermalNRMCreateAllScriptFiles2d(x, y, z, d, N, b,crystal)
    ThermalNRMReadMinimize2d(x,y,z,d,N,b,crystal);
    ThermalNRMCreateMerrillBatch2d(x, y, z, d, N, b,crystal);
end