function y = myExp(x,lambda)
    %Exponential function as parameterized by JAGs
    y=lambda*exp(-lambda.*x);
end