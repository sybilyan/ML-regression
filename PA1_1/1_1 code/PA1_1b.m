load('poly_data.mat')
k = length(sampx);
p = 6; %pΪ����
X0 = ones(p,k);


       
%������� X0=fei(x)
for i = 1:p-1
    X0(i + 1,:) = sampx .^ i;
end

sita_LS = LS(X0 , sampy);
sita_RLS = RLS(X0 , sampy);
sita_LASSO = LASSO(X0 , sampy);
sita_Robust = Robust(X0 , sampy);
[var_Bias , mean_Bias] = Bias(X0 , sampy);


for i = 1:p-1
    XN(i + 1,:) = polyx .^ i;
end 
    
y0_LS = XN' * sita_LS ;
y0_RLS = XN' * sita_RLS ;
y0_LASSO = XN' * sita_LASSO ;
y0_Robust = XN' * sita_Robust ;
y0_Bias = XN' * mean_Bias ;
var_fin = XN' * var_Bias * XN;

    %������õ�ϵ����ʼ�����������ʽ����
    
ms_LS = mean((y0_LS - polyy) .^ 2);
ms_RLS = mean((y0_RLS - polyy) .^ 2);
ms_LASSO = mean((y0_LASSO - polyy) .^ 2);
ms_RR = mean((y0_Robust - polyy) .^ 2);
ms_BR = mean((y0_Bias - polyy) .^ 2);

figure(1);
    disp(ms_LS);
    scatter(sampx,sampy,'*');
    hold on
    plot(polyx,polyy,'r');
    hold on
    plot(polyx,y0_LS,'g');
    suptitle('LS 5order');

figure(2);
    disp(ms_RLS);
    scatter(sampx,sampy,'*');
    hold on
    plot(polyx,polyy,'r');
    hold on
    plot(polyx,y0_RLS,'g');
    suptitle('RLS 5order');

figure(3);    
    disp(ms_LASSO);
    scatter(sampx,sampy,'*');
    hold on
    plot(polyx,polyy,'r');
    hold on
    plot(polyx,y0_LASSO,'g');
    suptitle('LASSO 5order');
    
figure(4);
    disp(ms_RR);
    scatter(sampx,sampy,'*');
    hold on
    plot(polyx,polyy,'r');
    hold on
    plot(polyx,y0_Robust,'g');
    suptitle('Robust 5order');
   
 figure(5);  
    scatter(sampx,sampy,'*');
    hold on
    plot(polyx,polyy,'r');
    hold on
    plot(polyx,y0_Bias,'g');
    suptitle('Bias 5order');    