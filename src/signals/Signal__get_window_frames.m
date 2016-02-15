%> @brief Takes a portion of a signal between startT and endT frames. NB: that the
%> child signal will memorize the offset to its father (the first-one, non recursive)
%> start: useful if you want to plot the signal with logical times.
%> If you want to specify seconds instead of frames, you should use @c Signal__get_window()
%>
%> @attention SEE ALSO:
%>  - Signal__get_window
%>  - Signal__get_offset
%
%> @param  Signal: the signal you want to take a portion of.
%> @param startT: the start time (frames)
%> @param endT: the end time (frames)

%> @retval Child: the cut signal
%
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Child = Signal__get_window_frames(Signal, startT, endT)

if(nargin ~= 3)
	error('Usage: ChildSig = Signal__get_window_frames(Signal, startT, endT)');
end

Signal__assert_mine(Signal);

Child = Signal; %Clone them. I wish they were dinosaurs. :p

%Take the portion of the signal we want
raw = Signal__get_raw(Signal);
if(endT > length(raw))
	endT = length(raw);
end
Child = Signal__set_raw(Child, raw(startT: endT));

%Sets the new offset of the signal
if(Signal__get_offset(Signal) > 0)
	warning(['The signal you want to take a portion was already cut. ' ...
	         'Are you sure you want that ?. Will proceed anyway']);
	offset = Signal__get_offset(Signal);
else
	offset = 0;
end
Child = Signal__set_offset(Child, startT + offset);

%Keep the signal preprocessing features (like 'low-passed', etc.)
if(isfield(Signal, 'preprocessing'))
	Child.preprocessing = Signal.preprocessing;
end

