function y = myPareto(x,alpha,c)
%Pareto function as parameterized by JAG's
y=alpha*c^(alpha)*x.^(-(alpha+1));
end