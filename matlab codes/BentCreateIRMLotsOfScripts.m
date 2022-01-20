%***********************
% 2019.9.25
% Run 2d bent model
% #type:6
% #model:114
%***********************
for i = 21:3:30 
   BentCreateIRMAllScriptFiles(40,40,40,3,10,i*10)
   BentCreateIRMAllScriptFiles(40,40,40,8,10,i*10)
   BentCreateIRMAllScriptFiles(48,40,40,8,10,i*10)
end

