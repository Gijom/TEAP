function offset = Signal_get_offset(Signal)
%Gets the offset(in frames) relative to its parent (the first it had, non recursive).
% Inputs:
%  Signal: the signal you want to know the offset
% Outputs:
%  offset: the signal offset, in frames
%
%SEE ALSO:
%  Signal_get_window
%  Signal_get_window_frames
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 1)
	error('Usage: offset = Signal_get_offset(Signal)');
end

Signal_assert_mine(Signal);

if(isfield(Signal, 'relatime'))
	offset = Signal.relatime;
else
	offset = 0;
end

%!assert(Signal_get_offset(Signal_new_empty()), 0)

%!test
%! sig = Signal_new_empty();
%! sig = Signal_set_samprate(sig, 1);
%! assert(Signal_get_offset(Signal_get_window(sig, 10, 20)), 10);
