load('count_data.mat')
k = size( trainx,1 );
p = 2; %p为阶数
X0=zeros(k*p, size(trainx , 2));
XN=zeros(k*p, size(testx , 2));

%构造矩阵 X0=fei(x)
for i = 1 : p
    for j = 1 : k 
        X0((i-1)*k+1,:) =trainx(j,:) .^ i;
    end
end


sita_LS = LS(X0 , trainy);
sita_RLS = RLS(X0 , trainy);
sita_LASSO = LASSO(X0 , trainy);
sita_Robust = Robust(X0 , trainy);
[var_Bias , mean_Bias] = Bias(X0 , trainy);



%构造矩阵 XN
for i = 1 : p
    for j = 1 : k 
        XN((i-1)*k+1,:)  =testx(j,:) .^ i;
    end
end

y0_LS = XN' * sita_LS ;
y0_RLS = XN' * sita_RLS ;
y0_LASSO = XN' * sita_LASSO ;
y0_Robust = XN' * sita_Robust ;

y0_Bias = XN' * mean_Bias ;
var_fin = XN' * var_Bias * XN;

%根据求得的系数初始化并构造多项式方程
    
mse_LS = mean((y0_LS - testy) .^ 2);
mse_RLS = mean((y0_RLS - testy) .^ 2);
mse_LASSO = mean((y0_LASSO - testy) .^ 2);
mse_RR = mean((y0_Robust - testy) .^ 2);
mse_BR = mean((y0_Bias - testy) .^ 2);

mae_LS = mean(abs (y0_LS - testy) );
mae_RLS = mean(abs (y0_RLS - testy));
mae_LASSO = mean(abs (y0_LASSO - testy));
mae_RR = mean(abs (y0_Robust - testy));
mae_BR = mean(abs (y0_Bias - testy));

yy = [testy, y0_LS, y0_RLS, y0_LASSO, y0_Robust];
figure
plot(yy);