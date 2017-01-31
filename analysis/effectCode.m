function varOut = effectCode(varIn)
    varOut = double(varIn);
    varOut(varIn==0)=-1;
end