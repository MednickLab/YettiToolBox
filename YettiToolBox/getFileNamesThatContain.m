function files = getFileNamesThatContain(location,strToContain,fileType,recursive,sortOrder)
%% Get filenames that in *location* that contain the substrings in the cell
%% array *strToContain* and that match the optional *fileType*
%% e.g. getFilesThatContain(pwd,{'STATS','Sub1'},'.mat') 
%% will search recursivly (set *recursive* to true)
%% if no specific strToContrain is supplied, the whole set of files (recursive or not) is returned
    if ~exist('recursive','var')
        recursive=false;
    end
    if ~exist('sortOrder','var')
        sortOrder = 'a2z';
    end
    location = strrep(location,'/',filesep);
    location = strrep(location,'\',filesep);
    if ~strcmp(location(end),filesep)
        location = [location filesep];
    end
    fileData = dir(location); %import Mat files only
    files = {fileData.name}; %create a list of all the names
    if strcmp(sortOrder,'date')
        [~,dateSort] = sort([fileData.datenum]);
        files = files(dateSort);
    end
    files = cellfun(@(x) strcat(location,x),files,'UniformOutput',false);
    if recursive
        for f=1:length(files)
            if isdir(files{f}) && ~strcmp(files{f}(end),'.')
                recursiveFiles = getFileNamesThatContain(files{f},strToContain,fileType,recursive);
                files = [files recursiveFiles];
            end
        end 
    end
    if ~isempty(strToContain)
        for iStr = 1:length(strToContain)           
            namesOfFilesThatMatch = ~cellfun(@isempty,strfind(files,strToContain{iStr})); %find names that match what we want (Start with STATS)
            files = files(namesOfFilesThatMatch); %Now use that to get a list of files that we want
        end
    end
    
    isNotDir = ~cellfun(@isdir,files); %Remove dirs
    files = files(isNotDir); 
    
    if exist('fileType','var') && ~isempty(fileType)
        namesOfFilesThatMatch = ~cellfun(@isempty,strfind(files,fileType)); %find names that match what we want (Start with STATS)    
        files = files(namesOfFilesThatMatch); %Now use that to get a list of files that we want
    end
end