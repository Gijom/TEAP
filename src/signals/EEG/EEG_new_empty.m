function Signal = EEG_new_empty()
% Creates a new EEG empty signal

Signal = Signal__new_empty();
Signal = Signal__set_name(Signal, EEG_get_signame());
Signal = Signal__set_unit(Signal, 'µV');

