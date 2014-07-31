function Signal = RES_assert_type(Signal)
%Makes sure that the given signal is a RES one
%If you want to know more about that, please see Signal_assert_type's document…

Signal = Signal_assert_type(Signal, RES_get_name())

