function Child = Signal__get_window(Signal, startT, endT)
%Takes a portion of a signal between startT and endT seconds. NB: that the
%child signal will memorize the offset to its father (the first-one, non recursive)
%start: useful if you want to plot the signal with logical times.
%If you want to specify frames (aka. samples) instead of seconds, you should
%use Signal__get_window_frames()
% Inputs:
%  Signal: the signal you want to take a portion of.
%  startT: the start time (s)
%  endT: the end time (s)
% Outputs:
%  Signal
%
%SEE ALSO:
%  Signal__get_window_frames
%  Signal_get_offset
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014


if(nargin ~= 3)
	error('Usage: ChildSig = Signal__get_window(Signal, startT, endT)');
end

Signal__assert_mine(Signal);


fs = Signal__get_samprate(Signal);

startTFrame = startT * fs;
endTFrame = endT * fs;

Child = Signal__get_window_frames(Signal, startTFrame, endTFrame);

%!error(Signal__get_window())
%!error(Signal__get_window(42))
%!error(Signal__get_window(42, 1))
%!error(Signal__get_window(42, 1, 2))

