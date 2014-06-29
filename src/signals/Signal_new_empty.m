function Signal = Signal_new_empty()
%Creates a new, empty, signal. This is mainly to represent the data structure

Signal.sampFreq = -1; %Should be modified by XXX_aqn()
Signal = Signal_set_samprate(-1);
Signal = Signal_set_raw(Signal, []);
Signal = Signal_set_unit(Signal, 'no unit');
Signal = Signal_set_name(Signal, 'invalid');
