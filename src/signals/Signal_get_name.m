function signalName = Signal_get_name(Signal)

if(~isfield(Signal, 'name'))
	error('Signal given is not a TEAPhysio signal')
end

signalName = Signal.name;

%!assert(strcmp(Signal_get_name(Signal_new_empty()), 'invalid'))
