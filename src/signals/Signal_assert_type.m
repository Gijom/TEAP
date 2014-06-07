function Signal_assert_type(Signal, nameWanted)
% Checks that the signal given on the input is of the type nameWanted
% This function is mainly used by SSS_assert_type(Sig), with params Sig and SSS.

if(nargin ~= 2)
	%If fucking matlab was clever, they'd have implemented print_usage, like octave
	error('Usage: Signal_assert_type(Signal, nameWanted)')
end

name = Signal_get_name(Signal);
if(!strcmp(name, nameWanted))
	error(['Signal is of type: ' name '. Should be ' nameWanted])
end
