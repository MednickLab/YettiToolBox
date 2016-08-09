function num=myStr2Num(strOrNum)
%converts a strOrNum to a number regarless of the inital type
    if isnumeric(strOrNum)
        num=strOrNum;
    else
        num=str2double(strOrNum);
    end
end