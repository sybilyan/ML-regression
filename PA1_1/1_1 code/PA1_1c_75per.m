load('poly_data.mat')
 i=3  
    sx = sampx(i:37);
    sy = sampy(i:37);
%更改数据数量

    k = length(sx);
    p = 6; %p为阶数
    X0 = ones(p,k);
%构造矩阵 X0=fei(x)

    for j = 1:p-1
        X0(j + 1,:) = sx .^ j;
    end

    sita_LS = LS(X0 , sy);
    sita_RLS = RLS(X0 , sy);
    sita_LASSO = LASSO(X0 , sy);
    sita_Robust = Robust(X0 , sy);
    [var_Bias , mean_Bias] = Bias(X0 , sy);


    for n = 1:p-1
        XN(n + 1,:) = polyx .^ n;
    end 
    
    y0_LS = XN' * sita_LS ;
    y0_RLS = XN' * sita_RLS ;
    y0_LASSO = XN' * sita_LASSO ;
    y0_Robust = XN' * sita_Robust ;
    y0_Bias = XN' * mean_Bias ;
    var_fin = XN' * var_Bias * XN;
     
    %根据求得的系数初始化并构造多项式方程
    
    ms_LS = mean((y0_LS - polyy) .^ 2);
    ms_RLS = mean((y0_RLS - polyy) .^ 2);
    ms_LASSO = mean((y0_LASSO - polyy) .^ 2);
    ms_RR = mean((y0_Robust - polyy) .^ 2);
    ms_BR = mean((y0_Bias - polyy) .^ 2);

figure
    subplot(3,2,1)
    disp(sita_LS);
    scatter(sx,sy,'*');
    hold on
    plot(polyx,polyy,'r');
    hold on
    plot(polyx,y0_LS,'g');
    title('75% LS 5order');

    subplot(3,2,2)
    disp(sita_RLS);
    scatter(sx,sy,'*');
    hold on
    plot(polyx,polyy,'r');
    hold on
    plot(polyx,y0_RLS,'g');
    title('75% RLS 5order');

    subplot(3,2,3)    
    disp(sita_LASSO);
    scatter(sx,sy,'*');
    hold on
    plot(polyx,polyy,'r');
    hold on
    plot(polyx,y0_LASSO,'g');
    title('75% LASSO 5order');
    
    subplot(3,2,4)
    disp(sita_Robust);
    scatter(sx,sy,'*');
    hold on
    plot(polyx,polyy,'r');
    hold on
    plot(polyx,y0_Robust,'g');
    title('75% Robust 5order');    
    
    subplot(3,2,5)  
    scatter(sx,sy,'*');
    hold on
    plot(polyx,polyy,'r');
    hold on
    plot(polyx,y0_Bias','g');
    title('75% Bias 5order'); 
