%> @file EMG__new_empty.m
%> @brief Creates a new EMG empty signal
function Signal = EMG__new_empty()

Signal = Signal__new_empty();
Signal = Signal__set_signame(Signal, EMG__get_signame());
Signal = Signal__set_unit(Signal, 'uV');

