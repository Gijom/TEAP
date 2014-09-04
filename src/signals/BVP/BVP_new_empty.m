function Signal = BVP_new_empty()
% Creates a new BVP empty signal

Signal = Signal__new_empty();
Signal = Signal__set_name(Signal, BVP_get_signame());
Signal = Signal__set_unit(Signal, 'undef');

