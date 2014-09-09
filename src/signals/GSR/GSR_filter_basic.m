function GSRsignal = GSR_filter_basic(GSRsignal)
%Cleans a signal adding a low-pass median filter to it. The window equals the
%sample rate, aka 1 sec.
% Inputs:
%  GSRsignal: the GSR signal.
% Outputs:
%  Signal: the filtered GSR signal
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014


%Make sure we have a GSR signal
GSRsignal = GSR__assert_type(GSRsignal);

sampRate = Signal__get_samprate(GSRsignal);

GSRsignal = Signal_filter1_low_median(GSRsignal, sampRate);
