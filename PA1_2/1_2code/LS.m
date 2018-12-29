function[ sita ] = LS( fei , y)

sita = (fei * fei')^(-1) * fei * y;  %构造参数估计sita
    

