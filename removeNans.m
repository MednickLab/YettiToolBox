function [data,idxsToRemove] = removeNans(data,dim)
    %Removes coloums or rows (dim) that contain nan's. Only works for 2d
    %matrixs
    if ~exist('dim','var')
        [~,dim] = max(size(data));
    end
    idxsToRemove = zeros(size(data,dim),1);
    for i = 1:size(data,dim)
        if dim==1
            if any(isnan(data(i,:)));
                idxsToRemove(i) = 1;
            end
        else
            if any(isnan(data(:,i)));
                idxsToRemove(i) = 1;
            end
        end
    end
    if dim==1
        data(logical(idxsToRemove),:) = []; 
    else
        data(:,logical(idxsToRemove)) = []; 
    end
end