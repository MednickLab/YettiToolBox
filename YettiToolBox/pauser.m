function pauser(delay,t0,sys_delay)
if nargin==1
  t0=clock;
  sys_delay=0;
elseif nargin==2
  sys_delay=0;
end

while etime(clock,t0)+sys_delay<delay
  % Do nothing...
end

return
