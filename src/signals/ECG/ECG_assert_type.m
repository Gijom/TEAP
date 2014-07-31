function Signal = ECG_assert_type(Signal)
%Makes sure that the given signal is an ECG one
%Please refer to Signal_assert_type for more documentation

Signal = Signal_assert_type(Signal, ECG_get_name());

