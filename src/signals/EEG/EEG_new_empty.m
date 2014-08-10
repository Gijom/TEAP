function Signal = EEG_new_empty()
% Creates a new EEG empty signal

Signal = Signal_new_empty();
Signal = Signal_set_name(Signal, EEG_get_signame());
Signal = Signal_set_unit(Signal, 'µV');

