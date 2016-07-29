function [part1,part2] = half(arrayIn)
%splits an array or matrix in 2. no error checking. use at own risk
    [rows,cols] = size(arrayIn);
    if cols==1 || rows==1
        part1 = arrayIn(1:(length(arrayIn)/2));
        part2 = arrayIn((length(arrayIn)/2+1):end); 
    elseif rows > cols
        part1 = arrayIn(1:(size(arrayIn,1)/2),:);
        part2 = arrayIn((size(arrayIn,1)/2+1):end,:);
    elseif cols >= rows
        part1 = arrayIn(:,1:(size(arrayIn,2)/2));
        part2 = arrayIn(:,(size(arrayIn,2)/2+1):end);              
    end
end