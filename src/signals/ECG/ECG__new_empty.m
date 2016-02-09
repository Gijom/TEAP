function Signal = ECG__new_empty()
% Creates a new ECG empty signal

Signal = Signal__new_empty();
Signal = Signal__set_signame(Signal, ECG__get_signame());
Signal = Signal__set_unit(Signal, 'uV');

%Create information specific to ECG
Signal.IBI = Signal__new_empty(); %Inter beat interval (empty if not computed) a vector otherwise
Signal.IBI = Signal__set_signame(Signal.IBI, 'IBI');
Signal.IBI = Signal__set_unit(Signal.IBI, 's'); %For the moment the user cannot choose it
Signal.IBI = Signal__set_samprate(Signal.IBI, 8); %For the moment the user cannot choose it

