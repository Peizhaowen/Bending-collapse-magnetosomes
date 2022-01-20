
% for r = 1:10
%     for b = 5:5:70
%         NRMDataRotate3d(40,40,40,8,10,r,b)
%         NRMDataRotate3d(100,100,100,3,10,r,b)
%     end
% end


for b = 10:10:300
    NRMDataRotate2d(40,40,40,8,10,b)
    NRMDataRotate2d(40,40,40,3,10,b)
    NRMDataRotate2d(48,40,40,8,10,b)
    NRMDataRotate2dc(40,40,40,8,10,b)
    NRMDataRotate2dc(100,100,100,3,10,b)
end

b = 324;
NRMDataRotate2d(40,40,40,8,10,b)
NRMDataRotate2d(40,40,40,3,10,b)
NRMDataRotate2d(48,40,40,8,10,b)
NRMDataRotate2dc(40,40,40,8,10,b)
NRMDataRotate2dc(100,100,100,3,10,b)