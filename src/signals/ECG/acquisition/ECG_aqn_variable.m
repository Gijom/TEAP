function Signal = ECG_aqn_variable(ECG, sampRate)
% ECG_aqn_variable gets an ECG signal from a variable
% Inputs:
%   ECG [1xN]: the ECG signal
%   sampRate [1x1]: the sampling rate, in Hz
% Outputs:
%   Signal: An ECG TEAPhysio signal

Signal = ECG_new_empty();
Signal = Signal_set_samprate(sampRate);

Signal.raw = 42; % FIXME Raw_convert_1D(GSR);


end

