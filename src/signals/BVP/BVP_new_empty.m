function Signal = BVP_new_empty()
% Creates a new BVP empty signal

Signal = Signal_new_empty();
Signal = Signal_set_name(Signal, BVP_get_signame());
Signal = Signal_set_unit(Signal, 'undef');

