%> @file BVP_filter_basic.m
%> @brief Cleans a signal adding a low-pass median filter to it. The window equals the
%> sample rate, aka 1 sec.
%> @param  BVPsignal: the @b BVP signal.
%> @retval  Signal: the filtered @b BVP signal
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function BVPsignal = BVP_filter_basic(BVPsignal)


%Make sure we have a BVP signal
BVPsignal = BVP__assert_type(BVPsignal);

sampRate = Signal__get_samprate(BVPsignal);

BVPsignal = Signal_filter1_low_median(BVPsignal, sampRate);

