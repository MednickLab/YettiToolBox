function y = myLogNorm(x,mu,sigma)    
    tau = 1/sigma^2;
    %Log norma function as parameterized by JAGs
    y=((tau/(2*pi))^(1/2))*(x.^(-1)).*exp((-tau*(log(x)-mu).^2)/2);
end

