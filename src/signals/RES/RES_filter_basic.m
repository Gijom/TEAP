function RESsignal = RES_filter_basic(RESsignal)
%Cleans a signal adding a low-pass mean filter to it. The window equals the
%sample rate, aka 1 sec.
% Inputs:
%  RESsignal: the RES signal.
% Outputs:
%  Signal: the filtered RES signal
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014


%Make sure we have a RES signal
RESsignal = RES__assert_type(RESsignal);

sampRate = Signal__get_samprate(RESsignal);

RESsignal = Signal_filter1_low_mean(RESsignal, round(sampRate/16));
