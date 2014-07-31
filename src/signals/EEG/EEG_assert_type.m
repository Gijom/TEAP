function Signal = EEG_assert_type(Signal)
%Asserts that the given signal is an EEG one
%Please refer to Signal_assert_type for more extensive documentation

Signal = Signal_assert_type(Signal, EEG_get_name());
