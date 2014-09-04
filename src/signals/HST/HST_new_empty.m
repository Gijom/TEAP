function Signal = HST_new_empty()
% Creates a new HST empty signal

Signal = Signal__new_empty();
Signal = Signal__set_name(Signal, HST_get_signame());
Signal = Signal__set_unit(Signal, '°C');

