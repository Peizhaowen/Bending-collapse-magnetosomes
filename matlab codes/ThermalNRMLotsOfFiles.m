% b = 0:30:300;
% for i = 1:11
%     ThermalNRMCreateAllScriptFiles2d(40, 40, 40, 3, 10, b(i),'c');
%     ThermalNRMCreateAllScriptFiles2d(40, 40, 40, 8, 10, b(i),'c');
%     ThermalNRMCreateAllScriptFiles2d(48, 40, 40, 8, 10, b(i),'c');
%     ThermalNRMCreateAllScriptFiles2d(40, 40, 40, 8, 10, b(i),'co');
% end
% % b = 10:10:70;
% % for i = 1:7
% %     ThermalNRMCreateAllScriptFiles3d(40, 40, 40, 8, 10, b(i), 'co');
% % end

b = 324;
ThermalNRMCreateAllScriptFiles2d(40, 40, 40, 3, 10, b,'c');
ThermalNRMCreateAllScriptFiles2d(40, 40, 40, 8, 10, b,'c');
ThermalNRMCreateAllScriptFiles2d(48, 40, 40, 8, 10, b,'c');
ThermalNRMCreateAllScriptFiles2d(40, 40, 40, 8, 10, b,'co');