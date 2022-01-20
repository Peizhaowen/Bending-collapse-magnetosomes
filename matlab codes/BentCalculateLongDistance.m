function D = BentCalculateLongDistance(x,y,z,d,N,b)
	
    aa =  b/(N-1);
    at = (b/(N-1))*pi/180;
    L1 =  (d/2)/cos(at/2) + x/2;
    r = L1/(tan(at/2));
    D = cos(at/2)*((L1*(r+y))/r - x/2)/1000;
	
	
end

