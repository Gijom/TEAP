function Signal = GSR_assert_type(Signal)
%Makes sure that the given signal is a GSR one
%Please refer to it's father function (Signal_assert_type()) for more doc ;)

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: Signal = GSR_assert_type(Signal)');
end

Signal = Signal_assert_type(Signal, GSR_get_name());

