function ThermalCreateRandomGroundstateScript3d(x, y, z, d, N, b, r, rand)
% ThermalCreateRandomGroundstateScript(40, 40, 40, 8, 10, 0, 'c')
meshpath = 'mesh_bent3d';
groundstatepath = 'groundstates_bent_random3d';
merrillpath = 'D:/magnetosomes_thermal';
scriptpath = 'D:/magnetosomes_thermal/scripts/groundstates_bent_random3d';
hysteresispath = 'hysteresis_groundstate_bent_random3d';
subfolder = sprintf('3dco_%gx_%gy_%gz_%gd_%dN_%db_%dr', x, y, z, d, N, b, r);
meshname = sprintf('magnetosome3d_%dx_%dy_%dz_%dd_%dN_%db_%dr', x, y, z, d, N, b, r);

[~,~,~] = mkdir(scriptpath);
% T = [0:20:560 575];
T = [20];

for n = 1:length(T)
    filename = sprintf('3dco_%gx_%gy_%gz_%gd_%dN_%db_%dr_%gT', x, y, z, d, N, b, r, T(n));
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, groundstatepath), [subfolder]);
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, hysteresispath));
    
    fileID = fopen(sprintf('%s/%s.script', scriptpath, filename),'w');
    for a = 1:100
        fprintf(fileID,'magnetite %g C \n', T(n));
        fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', meshpath, meshname);
        for i = 1:N-1
            Rrot =Bent3dGetAnisaxis(x,y,z,d,N,b,r,i,rand);
            fprintf(fileID, 'CubicAxes %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f %1.9f SD = %d \n',...
                Rrot(1,1),Rrot(1,2),Rrot(1,3),Rrot(2,1),Rrot(2,2),Rrot(2,3),Rrot(3,1),Rrot(3,2),Rrot(3,3), i);
        end
        fprintf(fileID,'CubicRotation 0 0.6154 -0.7854 SD = 10 \n');
        fprintf(fileID, 'Set MaxEnergyEvaluations 10000 \n');
        fprintf(fileID, 'Randomize all moments \n');
        fprintf(fileID, 'Minimize \n');
        fprintf(fileID, 'WriteMagnetization %s/%s/%s_%d \n', ...
            groundstatepath, subfolder, filename, a);
        fprintf(fileID, 'WriteHyst %s/%s \n', ...
            hysteresispath, filename);
        
        fprintf(fileID, '\n');
    end
    fclose(fileID);
end
end