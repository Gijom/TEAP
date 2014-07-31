function Signal = GSR_assert_type(Signal)
%Makes sure that the given signal is a GSR one
%Please refer to it's father function (Signal_assert_type()) for more doc ;)

Signal = Signal_assert_type(Signal, GSR_get_name());

