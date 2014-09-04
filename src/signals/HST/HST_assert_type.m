function Signal = HST_assert_type(Signal)
%Asserts that the given signal is a HST one
%Yo: if you want to know how this works, please see my master:Signal__assert_type

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: Signal = HST_assert_type(Signal)');
end

Signal = Signal__assert_type(Signal, HST_get_signame());

