
function [ sita ] = RLS(fei , y)
lamda = 0.5;
k = size(fei,1);
sita = (fei * fei'+ lamda * eye(k))^(-1) * fei * y;%构造参数估计sita
end


