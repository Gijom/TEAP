function Signal = Signal__set_offset(Signal, offset)
%Sets the offset of the specified signal
% Inputs:
%  Signal: the signal
%  offset: the offset of the signal, in frames/samples
% Outputs:
%  Signal: the modified signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 2 || nargout ~= 1)
	error('Usage: Signal = Signal__set_offset(Signal, offset)');
end

Signal__assert_mine(Signal);

Signal.relatime = offset;


