function Signal = HST_assert_type(Signal)
%Asserts that the given signal is a HST one
%Yo: if you want to know how this works, please see my master:Signal_assert_type

Signal = Signal_assert_type(Signal, HST_get_name());

