function [NumOfPlots] = hypnoplot_single(varargin)

if nargin==0
    error('No Stages Provided!')

elseif nargin==1 % Stages only
    % disp('1 argument entered')
    eStages = varargin{1}; % vector with respective stages
    eNumbers = 1:size(eStages,2); % vector with epoch numbers

    for i=1:size(eNumbers,2)
        if eStages(i) == 4
            eStages(i)=1;
        elseif eStages(i) == 1
            eStages(i) = 2;
        elseif eStages(i) == 2
            eStages(i) = 3;
        elseif eStages(i) == 3
            eStages(i) = 4;
        end
    end

    stairs(eNumbers,eStages,'Color',[0,0.25,0.63],'LineWidth',1.5);
    xlabel('Epoch #');

    ax=gca;
    ax.Color=[0.81 0.81 0.81];

    xlim([1 size(eStages,2)])

    ax.XTick=linspace(1,size(eStages,2),6);
    % ax.XTickLabel=eTicks;

    ax.YDir='reverse';
    ax.YTick = [0 1 2 3 4];
    ax.YTickLabel={'Awake','REM',' Stage 1','Stage 2','Stage 3'};
    ax.YGrid = 'on';

elseif nargin==2 % Stages and Times only
  % default xaxis Style will be with Time (mins)
    disp('2 argument entered')
    eStages = varargin{1}; % vector with respective stages
    eTimes = varargin{2}; % vector with epoch times
    eNumbers = 1:size(eStages,2); % vector with epoch numbers

    for i=1:size(eNumbers,2)
    %     disp(i)
        if eStages(i) == 4
            eStages(i)=1;
        elseif eStages(i) == 1
            eStages(i) = 2;
        elseif eStages(i) == 2
            eStages(i) = 3;
        elseif eStages(i) == 3
            eStages(i) = 4;
        end
    end

    stairs(eNumbers,eStages,'Color',[0,0.25,0.63],'LineWidth',1.5);
    xlabel('Time (mins)');

    ax=gca;
    ax.Color=[0.81 0.81 0.81];

    eTicks = linspace(eTimes(1),eTimes(end),6);
    xlim([1 size(eStages,2)])

    ax.XTick=linspace(1,size(eStages,2),6);
    ax.XTickLabel=eTicks;

    ax.YDir='reverse';
    ax.YTick = [0 1 2 3 4];
    ax.YTickLabel={'Awake','REM',' Stage 1','Stage 2','Stage 3'};
    ax.YGrid = 'on';

% elseif nargin==3 % Stages, Times, and xStyle
%   error('Too many arguments provided')
%     % disp('3 argument entered')
%     % eStages = varargin{1}; % vector with respective stages
%     % eTimes = varargin{2}; % vector with epoch times
%     % xStyle= varargin{3};
%     % % xStyles will be the following:
%     % %   Epoch #s
%     % %   Time (abs.mins)
%     % %   Time (rel.mins)
%     % eNumbers = 1:size(eStages,2); % vector with epoch numbers
%     %
%     % for i=1:size(eNumbers,2)
%     % %     disp(i)
%     %     if eStages(i) == 4
%     %         eStages(i)=1;
%     %     elseif eStages(i) == 1
%     %         eStages(i) = 2;
%     %     elseif eStages(i) == 2
%     %         eStages(i) = 3;
%     %     elseif eStages(i) == 3
%     %         eStages(i) = 4;
%     %     end
%     % end
%     %
%     % stairs(eNumbers,eStages,'Color',[0,0.25,0.63],'LineWidth',1.5);
%     % xlabel('Time (mins)');
%     %
%     % ax=gca;
%     % ax.Color=[0.81 0.81 0.81];
%     %
%     % eTicks = linspace(eTimes(1),eTimes(end),6);
%     % xlim([1 size(eStages,2)])
%     %
%     % ax.XTick=linspace(1,size(eStages,2),6);
%     % ax.XTickLabel=eTicks;
%     %
%     % ax.YDir='reverse';
%     % ax.YTick = [0 1 2 3 4];
%     % ax.YTickLabel={'Awake','REM',' Stage 1','Stage 2','Stage 3'};
%     % ax.YGrid = 'on';

else % too many arguments
    error('Invalid number of arguments provided!')
end


end
