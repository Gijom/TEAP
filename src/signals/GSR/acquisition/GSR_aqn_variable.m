function Signal = GSR_aqn_variable(rawGSR, sampRate)
% GSR_aqn_variable gets a GSR signal from a variable
% Inputs:
%   rawGSR [1xN]: the raw GSR signal
%   sampRate [1x1]: the sampling rate, in Hz
% Outputs:
%   Signal: A GSR TEAPhysio signal

if(nargin ~= 2)
	error('Usage: GSR_aqn_variable(rawGSR, sampRate)');
end


Signal = GSR_new_empty();
Signal = Signal_set_samprate(Signal, sampRate);

if(median(rawGSR) < 1)
	warning(['The signal given seems to be given in Siemens. I need Ohms. ' ...
	         'Automatic conversion applied']);
	rawGSR = 1./rawGSR;
end


Signal = Signal_set_raw(Signal, Raw_convert_1D(rawGSR));


end

