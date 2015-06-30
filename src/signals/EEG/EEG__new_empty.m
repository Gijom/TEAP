function Signal = EEG__new_empty()
% Creates a new EEG empty signal

Signal = Signal__new_empty();
Signal = Signal__set_signame(Signal, EEG__get_signame());
Signal = Signal__set_unit(Signal, 'uV'); % Matlab does not display 'µ'

