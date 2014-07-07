function signalName = Signal_get_name(Signal)
%Gets the name of a signal, eg: 'GSR' for a Galvanic Skin Response signal
% Inputs:
%  Signal: the signal you want to get the name of.
% Outputs:
%  signalName: the name of the signal (ex: 'GSR')
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014


if(nargin ~= 1)
	error('Usage: signalName = Signal_get_name(Signal)');
end

Signal_assert_mine(Signal);


if(~isfield(Signal, 'name'))
	error('Signal given is not a TEAPhysio signal')
end

signalName = Signal.name;

%!assert(strcmp(Signal_get_name(Signal_new_empty()), 'invalid'))

