%> @file GSR__assert_type.m
%> @brief Makes sure that the given signal is a GSR one
%> Please refer to it's father function (Signal__assert_type()) for more doc ;)
function Signal = GSR__assert_type(Signal)

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: Signal = GSR__assert_type(Signal)');
end

Signal = Signal__assert_type(Signal, GSR__get_signame());

