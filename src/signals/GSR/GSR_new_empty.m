function Signal = GSR_new_empty()
% Creates a new GSR empty signal

Signal = Signal_new_empty();
Signal = Signal_set_name(Signal, GSR_get_signame());
Signal = Signal_set_unit(Signal, 'Ohm');

