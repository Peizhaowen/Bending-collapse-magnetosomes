function Bent3dCreateNRMScript(x,y,z,d,N,r)
% Bent3dCreateNRMScript(40,40,40,8,10,1)
% Bent3dCreateNRMScript(100,100,100,3,10,1)
    % for NRM
    n_model = 10;
    
    merrillpath = 'D:/magnetosomes';
    domainpath = 'domainstates_bent3d_NRM';
    scriptpath = 'D:/magnetosomes/scripts/NRM_bent3d';
    pathmesh = 'mesh_bent3d_NRM';
    filename = sprintf('3dNRM%dx_%dy_%dz_%dd_%dN_%dr', x, y, z, d, N, r);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, domainpath), filename);
	fileID = fopen(sprintf('%s/%s_1a.script', scriptpath, filename),'w');
    fprintf(fileID,'magnetite 20 C \n');
    fprintf(fileID,sprintf('Set MaxMeshNumber %d\n',700/n_model+3));
    fprintf(fileID, 'Set MaxEnergyEvaluations 5000 \n');
    
    if  n_model == 10
        endnum = 440;
        startnum = 5;
    else
        endnum = 445;
        startnum = 1;
    end
    
    fprintf(fileID, 'ReadMesh 1 mesh_bent3d_NRM/magnetosome3d_%dx_%dy_%dz_%dd_10N_0b.pat\n',x,y,z,d);
    meshname = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_10N_%db_%dr', x, y, z, d, startnum, r);
    fprintf(fileID, 'ReadMesh %d %s/%s.pat\n', 2, pathmesh, meshname);
    
    for i = n_model:n_model:endnum
        meshname = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_10N_%db_%dr', x, y, z, d, i, r);
        fprintf(fileID, 'ReadMesh %d %s/%s.pat\n', (i/n_model)+2, pathmesh, meshname);
    end
    
    meshname = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_10N_449b_%dr', x, y, z, d, r);
    fprintf(fileID, 'ReadMesh %d %s/%s.pat\n', 3 + endnum/ n_model, pathmesh, meshname);
    
    for i = 450: n_model:700
        meshname = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_10N_%db_%dr', x, y, z, d, i, r);
        fprintf(fileID, 'ReadMesh %d %s/%s.pat\n', (i/n_model)+3, pathmesh, meshname);
    end

    fprintf(fileID, 'external field direction -0.543 0.239 0.805\n');
    NRMpath = 'NRM_bent_3d';
    fprintf(fileID, 'LoadMesh 1 \n');
    fprintf(fileID, 'ReadMagnetization scripts/NRM_bent3d/3d%dx_%dy_%dz_%dd_%dN_0b_0_mT_1a.dat \n', x, y, z, d, N);
    fprintf(fileID, 'WriteMagnetization %s/%s/%s_0b_1a \n',domainpath, filename, filename);
    fprintf(fileID, 'WriteHyst %s/remesh_%s_1a \n', NRMpath, filename);
    fprintf(fileID, 'WriteHyst %s/minimize_%s_1a \n', NRMpath, filename);

    % random angles for anis
    randpath = sprintf('D:/magnetosomes/randangle/randangle.csv'); 
    fid = fopen(randpath);
    Rand = textscan(fid, ' %f','delimiter',',');
    rand = Rand{1};
    
    b = startnum/10;
    Bent3dCreateNRMRemeshScript(x,y,z,d,N,b,r,rand,domainpath,filename,NRMpath,fileID,2,startnum)

    for j = 3:(2+endnum/n_model)
        b = (j-2)* n_model/10;
        Bent3dCreateNRMRemeshScript(x,y,z,d,N,b,r,rand,domainpath,filename,NRMpath,fileID,j,(j-2)* n_model)
    end

%     b = 445/10;
%     Bent3dCreateNRMRemeshScript(x,y,z,d,N,b,r,rand,domainpath,filename,NRMpath,47,444)
    
    b = 449/10;
    Bent3dCreateNRMRemeshScript(x,y,z,d,N,b,r,rand,domainpath,filename,NRMpath,fileID, 3 + endnum/n_model,449)
    
    fprintf(fileID, sprintf('LoadMesh %d \n',4 + endnum/n_model));
    fprintf(fileID, 'ReadMagnetization %s/%s/minimize_%s_449b_1a.dat\n',domainpath ,filename, filename);
    fprintf(fileID, 'WriteMagnetization %s/%s/minimize_%s_%db_1a\n',domainpath, filename, filename,450);
    fprintf(fileID, 'WriteHyst %s/remesh_%s_1a \n', NRMpath, filename);
    fprintf(fileID, 'WriteHyst %s/minimize_%s_1a \n', NRMpath, filename);
    
    for j = (5+endnum/n_model): (700/n_model+3)
        b = (j-3)* n_model/10;
        Bent3dCreateNRMRemeshScript(x,y,z,d,N,b,r,rand,domainpath,filename,NRMpath,fileID,j,(j-3)* n_model)
    end
    
    fprintf(fileID, '\n');
    fclose(fileID);
end