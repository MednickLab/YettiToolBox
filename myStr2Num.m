function num=myStr2Num(strOrNum)
%converts a strOrNum to a number regarless of the inital type
    if isempty(strOrNum)
        num = nan;
        return
    end
    if isnumeric(strOrNum)
        num=strOrNum;
    else
        num=str2double(strOrNum);
    end
end