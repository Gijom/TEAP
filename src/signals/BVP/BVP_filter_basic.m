function BVPsignal = BVP_filter_basic(BVPsignal)
%Cleans a signal adding a low-pass median filter to it. The window equals the
%sample rate, aka 1 sec.
% Inputs:
%  BVPsignal: the BVP signal.
% Outputs:
%  Signal: the filtered BVP signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014


%Make sure we have a BVP signal
BVPsignal = BVP_assert_type(BVPsignal);

sampRate = Signal__get_samprate(BVPsignal);

BVPsignal = Signal_filter1_low_median(BVPsignal, sampRate);

