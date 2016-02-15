%> @brief Cleans a signal adding a low-pass mean filter to it. The window equals the
%> sample rate, aka 1 sec.

%> @param  GSRsignal: the GSR signal.
%> @retval  Signal: the filtered GSR signal

%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function GSRsignal = GSR_filter_basic(GSRsignal)


%Make sure we have a GSR signal
GSRsignal = GSR__assert_type(GSRsignal);

sampRate = Signal__get_samprate(GSRsignal);

GSRsignal = Signal_filter1_low_mean(GSRsignal, round(sampRate/16));
