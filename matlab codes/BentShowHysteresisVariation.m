function BentShowHysteresisVariation(x, y, z, d, N ,b)
    
    num = max([length(x), length(y), length(z), length(d), length(N), length(b)]);
    x = x .* ones(1,num);
    y = y .* ones(1,num);
    z = z .* ones(1,num);
    d = d .* ones(1,num);
    N = N .* ones(1,num);
    b = b .* ones(1,num);
	
    H = linspace(-0.3, 0.3, 2000);    
    M = zeros(size(H)); 
    
    for n = 1:num
        M(n,:) = LoadAverageHysteresis(x(n), y(n), z(n), d(n), N(n), b(n), H);
    end
        
    PlotHysteresisAverage(H, M, x, y, z, d, N, b)
    
end