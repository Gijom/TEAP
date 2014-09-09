function Signal = HST__new_empty()
% Creates a new HST empty signal

Signal = Signal__new_empty();
Signal = Signal__set_signame(Signal, HST__get_signame());
Signal = Signal__set_unit(Signal, 'degC');

