function signalName = Signal__get_signame(Signal)
%Gets the name of a signal, eg: 'GSR' for a Galvanic Skin Response signal
% Inputs:
%  Signal: the signal you want to get the name of.
% Outputs:
%  signalName: the name of the signal (ex: 'GSR')
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014


if(nargin ~= 1)
	error('Usage: signalName = Signal__get_signame(Signal)');
end

Signal__assert_mine(Signal);


if(~isfield(Signal, 'name'))
	error('Signal given is not a TEAPhysio signal')
end

signalName = Signal.name;

%!assert(strcmp(Signal__get_signame(Signal__new_empty()), 'invalid'))

