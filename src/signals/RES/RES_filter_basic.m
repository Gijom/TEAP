%> @file RES_filter_basic.m
%> @brief Cleans a signal adding a low-pass mean filter to it. The window equals the
%> sample rate, aka 1 sec.

%> @param RESsignal: the RES signal.

%> @retval Signal: the filtered RES signal

%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function RESsignal = RES_filter_basic(RESsignal)


%Make sure we have a RES signal
RESsignal = RES__assert_type(RESsignal);

sampRate = Signal__get_samprate(RESsignal);

RESsignal = Signal_filter1_low_mean(RESsignal, round(sampRate/16));
