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





