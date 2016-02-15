%> @brief Makes sure that the given signal is an EMG one
%> Please refer to Signal__assert_type for more documentation
function Signal = EMG__assert_type(Signal)

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: Signal = EMG__assert_type(Signal)');
end

Signal = Signal__assert_type(Signal, EMG__get_signame());

