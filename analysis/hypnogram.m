% Function takes in a cell array with 1-3 cells (below in order)
% Cell #1 is always neccesary, this should contain epcohStage sets (1 or more)
% Cell #2 should contain epochStartTime sets (# of sets should be <= stage sets)
% Cell #3: An int (1-4) that specifies what you want to use on the X-Axis (optional)
%     1- Mins (1440 min clock)
%     2- Mins (rel to first epoch start time)
%     3- HH:MM (24 hr clock)
%     4- HH:MM (rel to first epoch start time)

% Note #1: When only epochStages are provided, the x axis is labeled with epoch #s
% Note #2: this fnction is capable of subplotting. If there are more EpochStage sets than epochTime sets, epoch #s will be used for stageSets that do not have a corresponding epochTime set.
% Note #3: When the third argument (cell containing int for X-Axis Styling) is omitted, the X-Axis is labeled with mins (1440 min clock)


function hypnogram(varargin)

  if nargin==0
    error('No Stages Provided!')
  elseif nargin==1 % Stages only
    stagesOnly(varargin{1})
  elseif nargin==2 % Stages and Times only
    stagesTimes(varargin{1},varargin{2})
  elseif nargin==3 % Stages, Times, and xStyle
    stagesTimesFormat(varargin{1},varargin{2},varargin{3})
  else % too many arguments
      error('Invalid number of arguments provided!')
  end
end %end of main function

function stagesOnly(stages)
  disp('1 argument entered')
  numOfPlots = size(stages,2); % number of stage data sets
  disp(numOfPlots)
  if numOfPlots==1
    eStages = formatStages(stages{1}); % vector with respective stages
    eNumbers = 1:size(eStages,2); % vector with epoch numbers

    stairs(eNumbers,eStages,'Color',[0,0.25,0.63],'LineWidth',1.5);
    xlabel('Epoch #');
    ax=gca;
    ax.Color=[0.81 0.81 0.81];
    xlim([1 size(eStages,2)])
    ax.XTick = round(linspace(1,size(eStages,2),6));
    ax.YDir='reverse';
    ax.YTick = [0 1 2 3 4];
    ax.YTickLabel={'Awake','REM',' Stage 1','Stage 2','Stage 3'};
    ax.YGrid = 'on';
  elseif numOfPlots>1
    % if there is more than one set of stage data, use subplots
    D = cellfun('size',stages,2);
    epochLimit = min(D);

    for n=1:numOfPlots

      eStages = formatStages(stages{n}); % vector with respective stages
      eStages = eStages(1:epochLimit);

      eNumbers = 1:size(eStages,2); % vector with epoch numbers

      subplot(numOfPlots,1,n)
      stairs(eNumbers,eStages,'Color',[0,0.25,0.63],'LineWidth',1.5);
      xlabel('Epoch #');
      ax=gca;
      ax.Color=[0.81 0.81 0.81];
      xlim([1 size(eStages,2)])
      ax.XTick = round(linspace(1,size(eStages,2),6));
      ax.YDir='reverse';
      ax.YTick = [0 1 2 3 4];
      ax.YTickLabel={'Awake','REM',' Stage 1','Stage 2','Stage 3'};
      ax.YGrid = 'on';
    end
  end
end %end of subfunction

function stagesTimes(stages, times)
  disp('2 argument entered')
  numOfPlots = size(stages,2); % number of stage data sets
  numOfSets = size(times,2); % number of Times sets
  if numOfPlots==1
    eStages = formatStages(stages{1}); % vector with respective stages
    eTimes = times{1}; % vector with epoch times
    eNumbers = 1:size(eStages,2); % vector with epoch numbers

    stairs(eNumbers,eStages,'Color',[0,0.25,0.63],'LineWidth',1.5);
    xlabel('Time');
    ax=gca;
    ax.Color=[0.81 0.81 0.81];
    eTicks = getHHMM(round(linspace(eTimes(1),eTimes(end),6)));

    xlim([1 size(eStages,2)])
    ax.XTick=linspace(1,size(eStages,2),6);
    ax.XTickLabel=eTicks;
    ax.YDir='reverse';
    ax.YTick = [0 1 2 3 4];
    ax.YTickLabel={'Awake','REM',' Stage 1','Stage 2','Stage 3'};
    ax.YGrid = 'on';
  elseif numOfPlots>1
    D = cellfun('size',stages,2);
    epochLimit = min(D);

    for n=1:numOfPlots
      if n > numOfSets
        eStages = formatStages(stages{n}); % vector with respective stages
        eStages = eStages(1:epochLimit);


        eNumbers = 1:size(eStages,2); % vector with epoch numbers

        subplot(numOfPlots,1,n)
        stairs(eNumbers,eStages,'Color',[0,0.25,0.63],'LineWidth',1.5);
        xlabel('Epoch #');
        ax=gca;
        ax.Color=[0.81 0.81 0.81];
        xlim([1 size(eStages,2)])
        ax.XTick = linspace(1,size(eStages,2),6);
        ax.YDir='reverse';
        ax.YTick = [0 1 2 3 4];
        ax.YTickLabel={'Awake','REM',' Stage 1','Stage 2','Stage 3'};
        ax.YGrid = 'on';
      else
        eStages = formatStages(stages{n}); % vector with respective stages
        eStages = eStages(1:epochLimit);

        eTimes = times{n}; % vector with epoch times
        eNumbers = 1:size(eStages,2); % vector with epoch numbers

        subplot(numOfPlots,1,n)
        stairs(eNumbers,eStages,'Color',[0,0.25,0.63],'LineWidth',1.5);
        xlabel('Time');
        ax=gca;
        ax.Color=[0.81 0.81 0.81];
        eTicks = round(linspace(eTimes(1),eTimes(end),6));
        xlim([1 size(eStages,2)])
        ax.XTick=linspace(1,size(eStages,2),6);
        ax.XTickLabel=eTicks;
        ax.YDir='reverse';
        ax.YTick = [0 1 2 3 4];
        ax.YTickLabel={'Awake','REM',' Stage 1','Stage 2','Stage 3'};
        ax.YGrid = 'on';
      end
    end
  end
end %end of subfunction

function stagesTimesFormat(stages, times, style)
  disp('3 argument entered')
  numOfPlots = size(stages,2); % number of stage data sets
  numOfSets = size(times,2); % number of Times sets
  xStyle = style{1}
  if numOfPlots==1
    eStages = formatStages(stages{1}); % vector with respective stages
    eTimes = times{1}; % vector with epoch times
    eNumbers = 1:size(eStages,2); % vector with epoch numbers

    stairs(eNumbers,eStages,'Color',[0,0.25,0.63],'LineWidth',1.5);
    xlabel('Time');
    ax=gca;
    ax.Color=[0.81 0.81 0.81];

    if xStyle == 1 % MINS are absolute, time of day
      eTicks = round(linspace(eTimes(1),eTimes(end),6));
      xlim([1 size(eStages,2)])
      ax.XTick=linspace(1,size(eStages,2),6);
      ax.XTickLabel=eTicks;
    elseif xStyle == 2 % MINS are relative to start of study
      eTicks = round((linspace(eTimes(1),eTimes(end),6))-eTimes(1));
      xlim([1 size(eStages,2)])
      ax.XTick=linspace(1,size(eStages,2),6);
      ax.XTickLabel=eTicks;
    elseif xStyle == 3 % HH:MM absolute
      eTicks = getHHMM(round(linspace(eTimes(1),eTimes(end),6)));
      xlim([1 size(eStages,2)])
      ax.XTick=linspace(1,size(eStages,2),6);
      ax.XTickLabel=eTicks;
    elseif xStyle == 4 % HH:MM relative

      eTicks = getHHMM(round((linspace(eTimes(1),eTimes(end),6))-eTimes(1)));
      xlim([1 size(eStages,2)])
      ax.XTick=linspace(1,size(eStages,2),6);
      ax.XTickLabel=eTicks;

    else
      error('Please enter a valid style (1 => Absolute, 2 => Relative, 3 => HH:MM Absolute, 4 => HH:MM Relative)');
    end

    ax.YDir='reverse';
    ax.YTick = [0 1 2 3 4];
    ax.YTickLabel={'Awake','REM',' Stage 1','Stage 2','Stage 3'};
    ax.YGrid = 'on';
  elseif numOfPlots>1
    D = cellfun('size',stages,2)
    epochLimit = min(D)

    for n=1:numOfPlots
      if n > numOfSets
        eStages = formatStages(stages{n}); % vector with respective stages
        eStages = eStages(1:epochLimit);

        eNumbers = 1:size(eStages,2); % vector with epoch numbers

        subplot(numOfPlots,1,n)
        stairs(eNumbers,eStages,'Color',[0,0.25,0.63],'LineWidth',1.5);
        xlabel('Epoch #');
        ax=gca;
        ax.Color=[0.81 0.81 0.81];
        xlim([1 size(eStages,2)])
        ax.XTick=linspace(1,size(eStages,2),6);
        ax.YDir='reverse';
        ax.YTick = [0 1 2 3 4];
        ax.YTickLabel={'Awake','REM',' Stage 1','Stage 2','Stage 3'};
        ax.YGrid = 'on';
      else
        eStages = formatStages(stages{n}); % vector with respective stages
        eStages = eStages(1:epochLimit);

        eTimes = times{n}; % vector with epoch times
        eNumbers = 1:size(eStages,2); % vector with epoch numbers

        subplot(numOfPlots,1,n)
        stairs(eNumbers,eStages,'Color',[0,0.25,0.63],'LineWidth',1.5);
        xlabel('Time');
        ax=gca;
        ax.Color=[0.81 0.81 0.81];

        if xStyle == 1 % MINS are absolute, time of day
          eTicks = round(linspace(eTimes(1),eTimes(end),6));
          xlim([1 size(eStages,2)])
          ax.XTick=linspace(1,size(eStages,2),6);
          ax.XTickLabel=eTicks;
        elseif xStyle == 2 % MINS are relative to start of study
          eTicks = round((linspace(eTimes(1),eTimes(end),6))-eTimes(1));
          xlim([1 size(eStages,2)])
          ax.XTick=linspace(1,size(eStages,2),6);
          ax.XTickLabel=eTicks;
        elseif xStyle == 3 % HH:MM absolute
          eTicks = getHHMM(round(linspace(eTimes(1),eTimes(end),6)));
          xlim([1 size(eStages,2)])
          ax.XTick=linspace(1,size(eStages,2),6);
          ax.XTickLabel=eTicks;
        elseif xStyle == 4 % HH:MM relative
          eTicks = getHHMM(round((linspace(eTimes(1),eTimes(end),6))-eTimes(1)));
          xlim([1 size(eStages,2)])
          ax.XTick=linspace(1,size(eStages,2),6);
          ax.XTickLabel=eTicks;
        else
          error('Please enter a valid style (1 => Absolute, 2 => Relative)');
        end

        ax.YDir='reverse';
        ax.YTick = [0 1 2 3 4];
        ax.YTickLabel={'Awake','REM',' Stage 1','Stage 2','Stage 3'};
        ax.YGrid = 'on';
      end
    end
  end

end %end of subfunction

function [epochStages] = formatStages(epochStages)
  for i=1:size(epochStages,2)
    if epochStages(i) == 4
        epochStages(i)=1;
    elseif epochStages(i) == 1
        epochStages(i) = 2;
    elseif epochStages(i) == 2
        epochStages(i) = 3;
    elseif epochStages(i) == 3
        epochStages(i) = 4;
    end
  end
end  % function

function [b] = getHHMM(a)

  colon = ':';
  % a = [75 90 105 120 135]; %this is the vector containing actualXticks

  if floor(a(1)/60) < 10 % a1 HH (first element)
      a1HH = ['0' int2str(floor(a(1)/60))];
  else
      a1HH = int2str(floor(a(1)/60));
  end
  if mod(a(1),60) < 10 % a1 MM (first element)
      a1MM = ['0' int2str(mod(a(1),60))];
  else
      a1MM = int2str(mod(a(1),60));
  end

  if floor(a(2)/60) < 10 % a HH (first element)
      a2HH = ['0' int2str(floor(a(2)/60))];
  else
      a2HH = int2str(floor(a(2)/60));
  end
  if mod(a(2),60) < 10 % a2 MM (first element)
      a2MM = ['0' int2str(mod(a(2),60))];
  else
      a2MM = int2str(mod(a(2),60));
  end

  if floor(a(3)/60) < 10 % a3 HH (first element)
      a3HH = ['0' int2str(floor(a(3)/60))];
  else
      a3HH = int2str(floor(a(3)/60));
  end
  if mod(a(3),60) < 10 % a3 MM (first element)
      a3MM = ['0' int2str(mod(a(3),60))];
  else
      a3MM = int2str(mod(a(3),60));
  end

  if floor(a(4)/60) < 10 % a4 HH (first element)
      a4HH = ['0' int2str(floor(a(4)/60))];
  else
      a4HH = int2str(floor(a(4)/60));
  end
  if mod(a(4),60) < 10 % a4 MM (first element)
      a4MM = ['0' int2str(mod(a(4),60))];
  else
      a4MM = int2str(mod(a(4),60));
  end

  if floor(a(5)/60) < 10 % a5 HH (first element)
      a5HH = ['0' int2str(floor(a(5)/60))];
  else
      a5HH = int2str(floor(a(5)/60));
  end
  if mod(a(5),60) < 10 % a5 MM (first element)
      a5MM = ['0' int2str(mod(a(5),60))];
  else
      a5MM = int2str(mod(a(5),60));
  end

  if floor(a(6)/60) < 10 % a6 HH (first element)
      a6HH = ['0' int2str(floor(a(6)/60))];
  else
      a6HH = int2str(floor(a(6)/60));
  end
  if mod(a(6),60) < 10 % a6 MM (first element)
      a6MM = ['0' int2str(mod(a(6),60))];
  else
      a6MM = int2str(mod(a(6),60));
  end

  a1 = [a1HH colon a1MM];
  a2 = [a2HH colon a2MM];
  a3 = [a3HH colon a3MM];
  a4 = [a4HH colon a4MM];
  a5 = [a5HH colon a5MM];
  a6 = [a6HH colon a6MM];

  b = {a1, a2, a3, a4, a5, a6}; % this is the vector containging the tickLabels

end  % function
