function Signal = HST_aqn_variable(rawHST, sampRate)
% HST_aqn_variable gets a HST signal from a variable
% Inputs:
%   rawHST [1xN]: the raw HST signal
%   sampRate [1x1]: the sampling rate, in Hz
% Outputs:
%   Signal: A HST TEAPhysio signal

Signal = HST_new_empty();
Signal = Signal_set_samprate(Signal, sampRate);

if(median(rawHST) > 70)
	warning(['The signal given seems to be given in °F. I need °C ! ' ...
	         'Automatic conversion applied. ' ...
	         'And stop using Fahrenheit, nobody uses it anyway !']);
	rawHST = (rawHST - 32) .* (5/9);
end

if(median(rawHST) < 20 || median(rawHST) > 45)
	error(['Something seems wrong with the HST signal: temperatures outside' ...
	       ' range (20; 54)']);
end


Signal = Signal_set_raw(Signal, Raw_convert_1D(rawHST));

