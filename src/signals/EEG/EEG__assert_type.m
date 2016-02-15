%> @file EEG__assert_type.m
%> @brief Asserts that the given signal is an EEG one
%> Please refer to @c Signal__assert_type for more extensive documentation
function Signal = EEG__assert_type(Signal)

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: Signal = EEG__assert_type(Signal)');
end

Signal = Signal__assert_type(Signal, EEG__get_signame());
