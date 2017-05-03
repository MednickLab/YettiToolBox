# YettiToolBox
Some helper function for matlab. Psychtoolbox helper, analysis helpers, etc

```binary2vector()```: Same functionality of matlabs inbuild de2bi, to be removed in future release


```closeFigure()```: KILL close all open figures (I forgot what this achives above the close all command)


```consecutiveOut = consecutiveValues(vectorIn)```: Finds all consective values in a vector. Does not currently handle NaN data, replace NaN with something else (some interger/float) before inputing into function. 
Returns a cell array with a struct for each element with the following feilds:
* vals: identiy of each consecutive value chunk
* lengthSeqs: length of consecutive value chunk
* startSeqs: Start of the consecutive value chunk
* endSeqs: end of the consecytive value chunks
    
    
```vectorOut = consecutiveValuesInv(consecutiveIn)```: The inverse of the ```consecutiveValues``` function.


```csvimport(filename, varargin)```: see this [MATLAB central](https://www.mathworks.com/matlabcentral/fileexchange/23573-csvimport). Frankly, readtable is a much better way to import csv data if you have matlab version > 2007


```dipstat``` a helpful file for plotting the status of a script or loop without scrolling the command window, see [MATLAB central](https://www.mathworks.com/matlabcentral/fileexchange/44673-overwritable-message-outputs-to-commandline-window)


```dPrime = dprime(pHit,pFA,N)``` Caculates the standard dprime ([signal detection theory](https://en.wikipedia.org/wiki/Sensitivity_index)) messure from false alarm rate ```pFA``` and hit rate ```pHit```. When pHit is one or pFA is zero, this function will return infinity unless N is supplied and then it will follow the convention detailed [here](http://www.talkstats.com/showthread.php/4063-dissertation-help-please...signal-detection-and-d-prime-alternative) 


```z = fisherR2Z(r)```: Performs the [fisher r2z transformation](http://davidmlane.com/hyperstat/A50760.html) so that 2 r's are normaly distributed and can be compared.


```files = getFileNamesThatContain(location,strToContain,fileType,recursive,sortOrder)```: A rather useful to load filenames that match some criteria:
 * location (required): the location to search in, use '.' if you want the current folder
 * str2Contain: the a cell array of strings that the filename must contain. May be empty cell array for no requried matches
 * fileType: the required filetype. May be and empty string ''
 * recursive: if set as true, this folder will recuirsivly drop into all subfolders searching for files that match
 * sortOrder (default 'a2z'): the return order of all the files. Can be by date last modified (first modified to last modified) ('date') or aphabetical ('a2z'). Note that if file search is recursive, then date sort will not work. TODO.
 * str2Ignore: A cell array of strings that returned filenames should not contain

```[part1,part2] = half(arrayIn)```: splits an array or matrix in 2 along its largest dimention.

```stacked = halfStack(arrayIn)```: Takes a row vector as an input, splits it in half and stacks it to create a 2 row vector of half the length

```out = interleave(a,b)```: Takes two input vectors or cells and interleaves their elements (merge like a zip)

```strOut = logical2str(logicalIn)```: Returns the strings conrisponding 'true' and 'false' for the logical input.

```sA = matchVariableNames(sA,sB)```: Creates nan filed variables in sA so that its variable names matchs the variables in sB. Size of variable in sA will be max height of variable in sA. Inputs can be structs or tables. Useful to concatinate two structs or tables with different variable names.

```num=myStr2Num(strOrNum)```: converts a string or double or cell{1} of double to a number regarless of the inital type

```idx = mySub2Ind(sz,idxPairs)```: a much faster version of matlabs built in sub2ind, where idxPairs is  [x1 y1; x2 y2]

```s = myTable2Struct(t)```: Converts a table to a struct (as opposed to a struct array like matlabs default does)

```function c = nanAdd(a,b)```: adds two numbers, if both nan return nan, if one is nan, return the non nan number

```x = nanzscore(X)```: zscore an array and ignoring NaN values

```[y,N,B,A]= passFilter(x,fs,fc,type,Rs)```: Use an elliptical filter to filter out high or low frequencies.
Variable Definitions:
* x: Input signal
* fs: Input signal sampling frequency in Hz
* fc: cutoff frequency (Hz)
* type: Filter type (high or low)
* Rs: Attenuation (dB)

```[M, I] = permn(V, N, K)```:permutations with repetition. See [MATLAB central](https://www.mathworks.com/matlabcentral/fileexchange/7147-permn-v--n--k-)

```printPercentComplete(currentLoop,totalLoops,initTime)```: Prints the percentage of done of some loop and overwrites old print so command screen does not scrole. Requries dispstat to be initialized. This should be run in a loop. If initTime is supplied then function will estimate time remaining, this may not be very accurate.

```tParent = recursiveNestedStruct2Table(level,nameOfLevel)```: Takes a nested structure or nested structure array (e.g. similar to a JSON object or python dictionary) and returns a flat 2 dimentional table. This function is called recursivly, and nameOfLevel is not required. Table will have a cloumn for each struct array index (taskA_taskA in below example). 
For example:
```
subData.taskA.response = [1 0 1 0];
subData.taskA.stimuli = {'a' 'b' 'c' 'd'};
subData.taskB.images = {'ia' 'ib' 'ic' 'id'};
subData.taskB.reactionTimes = [ 0.4 0.4 0.5 0.3];
subDataTable = recursiveNestedStruct2Table(subData)
 
 subDataTable Output:
     taskA_taskA    taskA_response    taskA_stimuli    taskB_taskB    taskB_images    taskB_reactionTimes
    ___________    ______________    _____________    ___________    ____________    ___________________
    1              1                 'a'              1              'ia'            0.4                
    1              0                 'b'              1              'ib'            0.4                
    1              1                 'c'              1              'ic'            0.5                
    1              0                 'd'              1              'id'            0.3                
```

```[data,idxsToRemove] = removeNans(data,dim)``` Removes coloums or rows (as specified in dim) that contain nan's. Only works for 2d matrixs. TODO

```t=removeOutliers(t)``` Removes outliers in numerical vector t at 2.5 SD, requires removeXSD. To be removed in future release. Use removeSXD instead.


```imgSize = scaleImageSize(imgSize,side,sideSize)``` resize the dimetions of an image (imgSize) to closest pixel while maining scale so that the requested (side) (1=y,2=x) is at a specific size (sideSize).

```[shuffledArray, shuffleIndex] = shuffle(arrayIn)```: randomly shuffles arrayIn along longest singlton dimention (cell or num array) or cols of array in if matrix. Returns shuffled array and shuffle idxs.

```[shuffledArray,shuffleLocs] = shuffleMix(arrayIn,dim)``` Randomly shuffles each row or colomn (dim) of arrayIn.

```parts = splitArray(arrayToSplit,splitNum,arrayToMatch)```: Split array at specific elements. the arrayToSplit will be split at each element that matchs splitNum. Alternatively, if arrayToMatch is suppiled, then arrayToSplit will be split at every point where splitNum==arrayToMatch. 

```strOut = strinsrt(str,loc,substr)```: Inserts substr into another str at location loc

```struct2csv(s,fn)```: Saves a structure (s) to a csv file named fs. See [MATLAB central](https://www.mathworks.com/matlabcentral/fileexchange/34889-struct2csv)

```structArray2structOfArrays(structArray)```: converts a 'structArray' e.g. p(1).a =1 , p(2).a=2 to sturct of arrays
    %p.a(1) = 1, p.a(2) = 2
    
```structData = structRowsToCols(structData)``` Converts all struct feilds that are row vectors (dim(1) < dim(2)) to column vectors

```dataOut = zscoreAcrossVariables(dataIn)```takes a series of arrays, one for each element in the cell array *dataIn* and zscores across all data across in all arrays, then repacks into original input cell array format 




















