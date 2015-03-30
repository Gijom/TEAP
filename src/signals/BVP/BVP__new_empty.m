function Signal = BVP__new_empty()
% Creates a new BVP empty signal

Signal = Signal__new_empty();
Signal = Signal__set_signame(Signal, BVP__get_signame());
Signal = Signal__set_unit(Signal, 'undef');

