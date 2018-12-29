

function [ sita ] = LASSO(fei,y)
    lamda=0.5;
    H = [(fei * fei'),(-(fei * fei'));(-(fei * fei')),(fei * fei')];
    f0 = [(fei * y);(-(fei * y))];
    f = (lamda * ones(size(fei ,1) * 2,1))- f0;
    x = quadprog(H,f,-eye(size(fei , 1) * 2), zeros(size(fei , 1) * 2, 1));
    
    sita = x(1:length(x)/2)-x(length(x)/2 +1:end);
end
