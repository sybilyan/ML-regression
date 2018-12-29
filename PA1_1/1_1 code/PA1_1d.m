load('poly_data.mat')

k = length(sampx);
p = 6; %p为阶数
X0 = ones(p,k);

sampy_out = sampy;
sampy_out(12) = -20;
sampy_out(24) = 5;
sampy_out(36) = 30;
sampy_out(48) = 20;
       
%构造矩阵 X0=fei(x)
for i = 1:p-1
    X0(i + 1,:) = sampx .^ i;
end

sita_LS = LS(X0 , sampy_out);
sita_RLS = RLS(X0 , sampy_out);
sita_LASSO = LASSO(X0 , sampy_out);
sita_Robust = Robust(X0 , sampy_out);
[var_Bias , mean_Bias] = Bias(X0 , sampy_out);


for i = 1:p-1
    XN(i + 1,:) = polyx .^ i;
end 
    
y0_LS = XN' * sita_LS ;
y0_RLS = XN' * sita_RLS ;
y0_LASSO = XN' * sita_LASSO ;
y0_Robust = XN' * sita_Robust ;
y0_Bias = XN' * mean_Bias ;

    %根据求得的系数初始化并构造多项式方程
    
ms_LS = mean((y0_LS - polyy) .^ 2);
ms_RLS = mean((y0_RLS - polyy) .^ 2);
ms_LASSO = mean((y0_LASSO - polyy) .^ 2);
ms_RR = mean((y0_Robust - polyy) .^ 2);
ms_BR = mean((y0_Bias - polyy) .^ 2);

figure(1);
    disp(sita_LS);
    scatter(sampx,sampy_out,'*');
    hold on
    plot(polyx,polyy,'r');
    hold on
    plot(polyx,y0_LS,'g');
    suptitle('LS 5order');

figure(2);
    disp(sita_RLS);
    scatter(sampx,sampy_out,'*');
    hold on
    plot(polyx,polyy,'r');
    hold on
    plot(polyx,y0_RLS,'g');
    suptitle('RLS 5order');

figure(3);    
    disp(sita_LASSO);
    scatter(sampx,sampy_out,'*');
    hold on
    plot(polyx,polyy,'r');
    hold on
    plot(polyx,y0_LASSO,'g');
    suptitle('LASSO 5order');
    
figure(4);
    disp(sita_Robust);
    scatter(sampx,sampy_out,'*');
    hold on
    plot(polyx,polyy,'r');
    hold on
    plot(polyx,y0_Robust,'g');
    suptitle('Robust 5order');
   
 figure(5);  
    scatter(sampx,sampy_out,'*');
    hold on
    plot(polyx,polyy,'r');
    hold on
    plot(polyx,y0_Bias,'g');
    suptitle('Bias 5order');    