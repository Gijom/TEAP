function Signal = EMG__new_empty()
% Creates a new EMG empty signal

Signal = Signal__new_empty();
Signal = Signal__set_signame(Signal, EMG__get_signame());
Signal = Signal__set_unit(Signal, 'uV');

