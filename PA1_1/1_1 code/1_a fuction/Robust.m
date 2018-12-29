
function[ sita ] = Robust(fei , y )
   
    i = size(fei,2);
    I = eye(i);
    H = [(-1)*(fei'),-I ; fei',-I];
    b = [-y ; y];
    
    p = size(fei, 1);
    D = zeros(p,1);
    O = ones(i,1);
    f = [D;O];
    
    x = linprog(f,H,b);
    sita=x(1:p);
end
    
