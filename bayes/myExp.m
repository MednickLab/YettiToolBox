function y = myExp(x,lambda,c)
    if ~exist('c','var')
        c = lambda;
    end
    %Exponential function as parameterized by JAGs
    y=c*exp(-lambda.*x);
end