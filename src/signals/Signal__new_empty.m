function Signal = Signal__new_empty()
%Creates a new, empty, signal. This is mainly to represent the data structure
% Output:
%  Signal: an empty signal
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

Signal.TEAPhysio = 'S'; %'S' because it is a signal. May have been 'B' for Bulk

%The sampling rate of the signal
Signal = Signal__set_samprate(Signal, -1);

%The raw data of the signal
Signal = Signal__set_raw(Signal, []);

%The unit of the signal (eg: °C, etc.)
Signal = Signal__set_unit(Signal, 'no unit');

%The name of the signal (eg: GSR)
Signal = Signal__set_signame(Signal, 'invalid');

%Was the signal NOT normalized/'baselined' ?
Signal = Signal__set_absolute(Signal, true);


