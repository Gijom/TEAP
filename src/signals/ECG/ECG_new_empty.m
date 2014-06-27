function Signal = ECG_new_empty()
% Creates a new ECG empty signal

Signal = Signal_new_empty();
Signal = Signal_set_name(Signal, 'ECG');
Signal = Signal_set_unit(Signal, '');

