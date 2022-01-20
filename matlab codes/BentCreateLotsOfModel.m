%***********************
% 2020.11.02
% Run 3d bent model
%***********************


for j = 0:30:300
    BentCuboctahedronCreateOneMagnetosomeMesh(40,40,40,8,10,j);
    BentCuboctahedronCreateOneMagnetosomeMesh(100,100,100,3,10,j);
    BentCreateOneMagnetosomeMesh(40,40,40,8,10,j);
    BentCreateOneMagnetosomeMesh(40,40,40,3,10,j);
    BentCreateOneMagnetosomeMesh(48,40,40,8,10,j);
end
