function Signal = Signal_new_empty()
%Creates a new, empty, signal. This is mainly to represent the data structure

Signal.TEAPhysio = 42; %Creates a TEAPhysio signal; arbitrary value to keep the
                       % field

%The sampling rate of the signal
Signal = Signal_set_samprate(Signal, -1);

%The raw data of the signal
Signal = Signal_set_raw(Signal, []);

%The unit of the signal (eg: °C, etc.)
Signal = Signal_set_unit(Signal, 'no unit');

%The name of the signal (eg: GSR)
Signal = Signal_set_name(Signal, 'invalid');

%Was the signal normalized/'baselined' ?
Signal = Signal_set_absolute(false);
