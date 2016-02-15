%> @file Signal__get_signame.m
%> @brief Gets the name of a signal, eg: 'GSR' for a Galvanic Skin Response signal
%> @param  Signal: the signal you want to get the name of.
%> @retval  signalName: the name of the signal (ex: 'GSR')
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function signalName = Signal__get_signame(Signal)


if(nargin ~= 1)
	error('Usage: signalName = Signal__get_signame(Signal)');
end

Signal__assert_mine(Signal);


if(~isfield(Signal, 'name'))
	error('Signal given is not a TEAPhysio signal')
end

signalName = Signal.name;

%!assert(strcmp(Signal__get_signame(Signal__new_empty()), 'invalid'))

