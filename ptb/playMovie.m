function [movieData,exit] = playMovie(ptb, moviename)
% Most simplistic demo on how to play a movie.
%
% SimpleMovieDemo(moviename [, windowrect=[]]);
%
% This bare-bones demo plays a single movie whose name has to be provided -
% including the full filesystem path to the movie - exactly once, then
% exits. This is the most minimalistic way of doing it. For a more complex
% demo see PlayMoviesDemo. The remaining demos show more advanced concepts
% like proper timing etc.
%
% The demo will play our standard DualDiscs.mov movie if the 'moviename' is
% omitted.
%

% History:
% 02/05/2009  Created. (MK)
% 06/17/2013  Cleaned up. (MK)
exit = false;

% Check if Psychtoolbox is properly installed:
AssertOpenGL;

if IsWin && ~IsOctave && psychusejava('jvm')
    fprintf('Running on Matlab for Microsoft Windows, with JVM enabled!\n');
    fprintf('This may crash. See ''help GStreamer'' for problem and workaround.\n');
    warning('Running on Matlab for Microsoft Windows, with JVM enabled!');
end

try  
    % Open movie file:
    [movie,dur,fps] = Screen('OpenMovie', ptb.win, moviename);
    
    % Start playback engine:
    Screen('PlayMovie', movie, 1);
    idx = 1;
    idxSec = 1;
    prevSec = 1;
    movieData.movieName = moviename;
    movieData.frames = nan(round(dur*fps),1);
    movieData.secSync = nan(floor(dur),1);
    movieData.initSyncTimes = initTaskSync(ptb);
    
    % Playback loop: Runs until end of movie or keypress:
    while ~exit
        % Wait for next movie frame, retrieve texture handle to it
        tex = Screen('GetMovieImage', ptb.win, movie);
        
        % Valid texture returned? A negative value means end of movie reached:
        if tex<=0
            % We're done, break out of loop:
            break;
        end
        
        % Draw the new texture immediately to screen:
        Screen('DrawTexture', ptb.win, tex,[],[0 0 ptb.xRes ptb.yRes]);
        if idx > prevSec+fps
            addSyncRec(ptb);
        end
        % Update display:
        movieData.frames(idx) = Screen('Flip', ptb.win);        
        if idx > prevSec+fps          
            prevSec = idx;
            movieData.secSync(idxSec) = movieData.frames(idx);
            idxSec = idxSec+1;
        end
        idx = idx+1;
        
        % Release texture:
        Screen('Close', tex);
        if strcmp(getLastKey(),'ESCAPE'); exit=true; break; end;
    end
    
    % Stop playback:
    Screen('PlayMovie', movie, 0);
    
    % Close movie:
    Screen('CloseMovie', movie);
    
catch %#ok<CTCH>
    sca;
    psychrethrow(psychlasterror);
end

return