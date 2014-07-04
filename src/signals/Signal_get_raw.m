function Raw = Signal_get_raw(Signal)
%Returns the raw data of the signal
% Inputs:
%  Signal: the signal you want the raw data of
% Outputs:
%  Raw: the raw data of the signal
%

if(nargin ~= 1)
	error('Usage: Signal_get_raw(Signal)');
end

Signal_assert_mine(Signal);

Raw = Signal.raw;

