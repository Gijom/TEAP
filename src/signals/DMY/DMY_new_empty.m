function Signal = DMY_new_empty()
% Creates a new DMY empty signal

Signal = Signal__new_empty();
Signal = Signal__set_name(Signal, DMY_get_signame());
Signal = Signal__set_unit(Signal, 'Franks');

