function Signal = ECG_new_empty()
% Creates a new ECG empty signal

Signal = Signal__new_empty();
Signal = Signal__set_name(Signal, ECG_get_signame());
Signal = Signal__set_unit(Signal, '');

