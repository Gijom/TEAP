function Signal = GSR__new_empty()
% Creates a new GSR empty signal

Signal = Signal__new_empty();
Signal = Signal__set_signame(Signal, GSR__get_signame());
Signal = Signal__set_unit(Signal, 'Ohm');

