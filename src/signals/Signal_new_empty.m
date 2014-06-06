function Signal = Signal_new_empty()
%Creates a new, empty, signal. This is mainly to represent the data structure

Signal.sampFreq = -1; %Should be modified by XXX_aqn()
Signal.raw = [];
Signal.name = 'invalid';
