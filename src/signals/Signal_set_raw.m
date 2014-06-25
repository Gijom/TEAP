function Signal = Signal_set_raw(Signal, raw)
%Sets the raw data of the signal S

Signal.raw = raw;

%As the signal changed, we remove it's features
Signal = Signal_rm_features(Signal);
