function offset = Signal_get_offset(Signal)
%Gets the offset(in frames) relative to its parent (the first it had, non recursive).
% Inputs:
%  Signal: the signal you want to know the offset
% Outputs:
%  offset: the signal offset, in frames
%SEE ALSO:
%  Signal_get_window
%  Signal_get_window_frames
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(isfield(Signal, 'relatime'))
	offset = Signal.relatime;
else
	offset = 0;
end
