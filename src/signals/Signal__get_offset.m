function offset = Signal__get_offset(Signal)
%Gets the offset(in frames) relative to its parent (the first it had, non recursive).
% Inputs:
%  Signal: the signal you want to know the offset
% Outputs:
%  offset: the signal offset, in frames
%
%SEE ALSO:
%  Signal__get_window
%  Signal__get_window_frames
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

if(nargin ~= 1)
	error('Usage: offset = Signal__get_offset(Signal)');
end

Signal__assert_mine(Signal);

if(isfield(Signal, 'relatime'))
	offset = Signal.relatime;
else
	offset = 0;
end

%!assert(Signal__get_offset(Signal__new_empty()), 0)

%!test
%! sig = Signal__new_empty();
%! sig = Signal__set_samprate(sig, 1);
%! assert(Signal__get_offset(Signal__get_window(sig, 10, 20)), 10);
