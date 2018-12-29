function[var, mean] = Bias(fei , y)
p = size(fei,1);
alpha=1;
var0=1;
var = ((alpha)^(-1) * eye(p) + (var0)^(-1)* fei * fei')^(-1);
mean = (var0)^(-1) * var * fei * y  ;
 

end

  