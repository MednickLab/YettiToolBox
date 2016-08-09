function text = stripFormatChars(text)
    formatChars = {'<n>','</n>','<i>','<b>','</b>','<u>','</u>','<nl>'};
    for f=1:length(formatChars)
        text = strrep(text,formatChars{f},'');
    end
end