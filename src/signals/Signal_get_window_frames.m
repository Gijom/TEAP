function Child = Signal_get_window_frames(Signal, startT, endT)
%Takes a portion of a signal between startT and endT frames. NB: that the
%child signal will memorize the offset to its father (the first-one, non recursive)
%start: useful if you want to plot the signal with logical times.
%If you want to specify seconds instead of frames, you should use Signal_get_window()
% Inputs:
%  Signal: the signal you want to take a portion of.
%  startT: the start time (frames)
%  endT: the end time (frames)
% Outputs:
%  Child: the cut signal
%
%SEE ALSO:
%  Signal_get_window
%  Signal_get_offset
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 3)
	error('Usage: ChildSig = Signal_get_window_frames(Signal, startT, endT)');
end

Signal_assert_mine(Signal);

if(isfield(Signal, 'relatime')) %noatime too ? :P
	warning(['The signal you want to take a portion was already cut. ' ...
	         'Are you sure you want that ?. Will proceed anyway']);
	offset = Signal.relatime;
else
	offset = 0;
end


Child = Signal; %Clone them. I wish they were dinosaurs.

Child.relatime = startT + offset;

raw = Signal_get_raw(Signal);
if(endT > length(raw))
	endT = length(raw);
end

Child = Signal_set_raw(Child, raw(startT: endT));

%Keep the signal preprocessing features (like 'low-passed', etc.)
if(isfield(Signal, 'preprocessing'))
	Child.preprocessing = Signal.preprocessing;
end

