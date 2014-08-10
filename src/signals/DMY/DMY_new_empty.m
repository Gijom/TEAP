function Signal = DMY_new_empty()
% Creates a new DMY empty signal

Signal = Signal_new_empty();
Signal = Signal_set_name(Signal, DMY_get_signame());
Signal = Signal_set_unit(Signal, 'Franks');

