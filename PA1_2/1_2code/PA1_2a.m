load('count_data.mat')
k = length( trainx );

sita_LS = LS(trainx , trainy);
sita_RLS = RLS(trainx , trainy);
sita_LASSO = LASSO(trainx , trainy);
sita_Robust = Robust(trainx , trainy);
[var_Bias , mean_Bias] = Bias(trainx , trainy);

    
y0_LS = testx' * sita_LS ;
y0_RLS = testx' * sita_RLS ;
y0_LASSO = testx' * sita_LASSO ;
y0_Robust = testx' * sita_Robust ;

y0_Bias = testx' * mean_Bias ;
var_fin = testx' * var_Bias * testx;
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
% disp(mse_LS,mse_RLS,mse_LASSO,mse_RR,mse_BR);
% disp(mae_LS,mae_RLS,mae_LASSO,mae_RR,mae_BR);

% figure(1);
%     scatter(trainx,trainy,'*');
%     hold on
%     plot(testx,testy,'r');
%     hold on
%     plot(testx,y0_LS,'g');
%     suptitle('LS 5order');
% 
% figure(2);
%    
%     scatter(trainx,trainy,'*');
%     hold on
%     plot(testx,testy,'r');
%     hold on
%     plot(testx,y0_RLS,'g');
%     suptitle('RLS 5order');
% 
% figure(3);    
%     
%     scatter(trainx,trainy,'*');
%     hold on
%     plot(testx,testy,'r');
%     hold on
%     plot(testx,y0_LASSO,'g');
%     suptitle('LASSO 5order');
%     
% figure(4);
%     
%     scatter(trainx,trainy,'*');
%     hold on
%     plot(testx,testy,'r');
%     hold on
%     plot(testx,y0_Robust,'g');
%     suptitle('Robust 5order');
%    
%  figure(5);  
%     
%     scatter(trainx,trainy,'*');
%     hold on
%     plot(testx,testy,'r');
%     hold on
%     plot(testx,y0_Bias,'g');
%     suptitle('Bias 5order');    