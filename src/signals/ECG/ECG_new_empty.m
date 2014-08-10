function Signal = ECG_new_empty()
% Creates a new ECG empty signal

Signal = Signal_new_empty();
Signal = Signal_set_name(Signal, ECG_get_signame());
Signal = Signal_set_unit(Signal, '');

