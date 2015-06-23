function Signal = BVP__new_empty()
% Creates a new BVP empty signal

Signal = Signal__new_empty();
Signal = Signal__set_signame(Signal, BVP__get_signame());
Signal = Signal__set_unit(Signal, 'undef');

%Create IBI information
Signal.IBI = Signal__new_empty(); %Inter beat interval (empty if not computed) a vector otherwise
Signal.IBI = Signal__set_signame(Signal.IBI, 'IBI');
Signal.IBI = Signal__set_unit(Signal.IBI, 's'); %For the moment the user cannot choose it
Signal.IBI = Signal__set_samprate(Signal.IBI, 4); %For the moment the user cannot choose it
