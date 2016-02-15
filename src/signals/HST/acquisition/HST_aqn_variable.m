%> @brief HST_aqn_variable gets a HST signal from a variable
%> Copyright Frank Villaro-Dixon, BSD Simplified, 2014

%> @param rawHST [1xN] the raw HST signal
%> @param sampRate [1x1] the sampling rate, in Hz

%> @retval Signal A HST TEAPhysio signal
function Signal = HST_aqn_variable(rawHST, sampRate)


if(nargin ~= 2)
	error('Usage: HST_aqn_variable(rawHST, sampRate)');
end

Signal = HST__new_empty();
Signal = Signal__set_samprate(Signal, sampRate);

if(median(rawHST) > 70)
	warning(['The signal given seems to be given in °F. I need °C ! ' ...
	         'Automatic conversion applied. ' ...
	         'And stop using Fahrenheit, nobody uses them anyway !']);
	rawHST = (rawHST - 32) .* (5/9);
end

if(median(rawHST) < 4 && median(rawHST) > -4) %we may have a relative signal
	Signal = Signal__set_absolute(Signal, false);
elseif(median(rawHST) < 20 || median(rawHST) > 45)
	error(['Something seems wrong with the HST signal: temperatures outside' ...
	       ' range (20; 54)']);
end


Signal = Signal__set_raw(Signal, Raw_convert_1D(rawHST));

%And, we filter the signal, else it's useless
Signal = HST_filter_basic(Signal);

