# YettiToolBox
Some helper function for matlab. Psychtoolbox helper, analysis helpers, etc

```binary2vector()```: Same functionality of matlabs inbuild de2bi, to be removed in future release

```closeFigure()```: KILL close all open figures (I forgot what this achives above the close all command)

```consecutiveOut = consecutiveValues(vectorIn)```: Finds all consective values in a vector. Does not currently handle NaN data, replace NaN with something else (some interger/float) before inputing into function. 
Returns a cell array with a struct for each element with the following feilds:
    - vals: identiy of each consecutive value chunk
    - lengthSeqs: length of consecutive value chunk
    - startSeqs: Start of the consecutive value chunk
    - endSeqs: end of the consecytive value chunks


