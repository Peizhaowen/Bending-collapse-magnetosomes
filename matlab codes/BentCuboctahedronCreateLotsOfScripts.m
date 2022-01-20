%***********************
% 2019.9.25
% Run 2d bent model
% #type:6
% #model:114
% Cuboctahedron model
%***********************

for i = 0:3:30
    BentCuboctahedronCreateAllScriptFiles(40,40,40,8,10,i*10)
    %BentCuboctahedronCreateAllScriptFiles(100,100,100,3,10,i*10);
end

% for i = 21:3:30
%    % BentCuboctahedronCreateAllScriptFiles(40,40,40,8,10,i*10)
%     BentCuboctahedronCreateAllScriptFiles(40,40,40,8,10,i*10);
% end


