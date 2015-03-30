function Signal = RES__assert_type(Signal)
%Makes sure that the given signal is a RES one
%If you want to know more about that, please see Signal__assert_type's document…

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: Signal = RES__assert_type(Signal)');
end

Signal = Signal__assert_type(Signal, RES__get_signame());

