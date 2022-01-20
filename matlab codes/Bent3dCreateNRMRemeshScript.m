function Bent3dCreateNRMRemeshScript(x,y,z,d,N,b,r,rand,domainpath,filename,NRMpath,fileID, id,bid)
    fprintf(fileID, 'Remesh %d \n',id);
    fprintf(fileID, 'WriteMagnetization %s/%s/remesh_%s_%db_1a \n',domainpath, filename, filename,bid);
    if bid ~= 5 & bid ~= 449
        fprintf(fileID, 'WriteHyst %s/remesh_%s_1a \n', NRMpath, filename);
    end
    for i = 1:N-1
        Rrot =Bent3dGetAnisaxis(x,y,z,d,N,b,r,i,rand);
        fprintf(fileID, 'CubicAxes %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f SD = %d \n',...
            Rrot(1,1),Rrot(1,2),Rrot(1,3),Rrot(2,1),Rrot(2,2),Rrot(2,3),Rrot(3,1),Rrot(3,2),Rrot(3,3), i);
    end
    fprintf(fileID,'CubicRotation 0 0.6154 -0.7854 SD = 10 \n');

    fprintf(fileID, 'External field strength 0 mT \n');
    fprintf(fileID, 'Minimize\n');
    fprintf(fileID, 'WriteMagnetization %s/%s/minimize_%s_%db_1a\n',domainpath, filename, filename,bid);
    if bid ~= 5 & bid ~= 449
        fprintf(fileID, 'WriteHyst %s/minimize_%s_1a \n', NRMpath, filename);
    end
end