function Signal = Signal_assert_type(Signal, nameWanted)
% Checks that the signal given on the input is of the type nameWanted
% This function is mainly used by SSS_assert_type(Sig), with params Sig and SSS.
% NOTA BENE: in the case that Signal is a BULK signal, this function will
%return, if it exists, the wanted signal, or fail if it doesn't.
% Input:
%  Signal: The signal you want to make sure of the type (can be a BULK signal,
%          in that case, will take the component.
%  nameWanted: the type the signal must be of (ex: 'GSR').
% Output:
%  Signal: the signal. Can be the same as the input if single signal, or the
%          signal from the bulk if the input signal is a bulk one.

if(nargin ~= 2 || nargout ~= 1)
	%If fucking matlab was clever, they'd have implemented print_usage, like octave
	error('Usage: Signal = Signal_assert_type(Signal, nameWanted)')
end

%First, make sure it's a TEAPhysio signal
Signal_assert_mine(Signal);

%TODO: switch: BULK or not ?

%And then, compare the name
name = Signal_get_name(Signal);
if(~strcmp(name, nameWanted))
	error(['Signal is of type: ' name '. Should be ' nameWanted])
end

