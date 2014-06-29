function Signal = RES_new_empty()
% Creates a new RES empty signal

Signal = Signal_new_empty();
Signal = Signal_set_name(Signal, 'RES');
Signal = Signal_set_unit(Signal, 'µV'); %FIXME

