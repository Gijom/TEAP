function Signal = Signal_new_empty()
%Creates a new, empty, signal. This is mainly to represent the data structure

Signal.TEAPhysio = 42; %Create a TEAPhysio signal; arbitrary value to keep the 
%field;
Signal = Signal_set_samprate(Signal, -1);
Signal = Signal_set_raw(Signal, []);
Signal = Signal_set_unit(Signal, 'no unit');
Signal = Signal_set_name(Signal, 'invalid');
