%> @file Signal__get_window.m
%> @brief Takes a portion of a signal between startT and endT seconds. NB: that the
%> child signal will memorize the offset to its father (the first-one, non recursive)
%> start: useful if you want to plot the signal with logical times.
%> If you want to specify frames (aka. samples) instead of seconds, you should
%> use @c Signal__get_window_frames()

%> @param  Signal: the signal you want to take a portion of.
%> @param  startT: the start time (s)
%> @param  endT: the end time (s)

%> @retval Signal: son signal
%
%> @attention SEE ALSO:
%> - Signal__get_window_frames
%> - Signal__get_offset
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Child = Signal__get_window(Signal, startT, endT)


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

