function Child = Signal_get_window(Signal, startT, endT)
%Takes a portion of a signal between startT and endT seconds. NB: that the
%child signal will memorize the offset to its father (the first-one, non recursive)
%start: useful if you want to plot the signal with logical times.
%If you want to specify frames (aka. samples) instead of seconds, you should
%use Signal_get_window_frames()
% Inputs:
%  Signal: the signal you want to take a portion of.
%  startT: the start time (s)
%  endT: the end time (s)
% Outputs:
%  Signal
%
%SEE ALSO:
%  Signal_get_window_frames
%  Signal_get_offset
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

fs = Signal_get_samprate(Signal);

startTFrame = startT * fs;
endTFrame = endT * fs;

Child = Signal_get_window_frames(Signal, startTFrame, endTFrame);

