function Signal = BVP_assert_type(Signal)
%Asserts that the given signal is a BVP one
%Please refer to Signal__assert_type for more and extensive documentation ;)

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: Signal = BVP_assert_type(Signal)');
end


Signal = Signal__assert_type(Signal, BVP_get_signame());

