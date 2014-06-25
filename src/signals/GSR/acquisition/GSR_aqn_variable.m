function Signal = GSR_aqn_variable(rawGSR, sampFreq)
% GSR_aqn_variable gets a GSR signal from a variable
% Inputs:
%   rawGSR [1xN]: the raw GSR signal
%   sampFreq [1x1]: the sampling rate, in Hz
% Outputs:
%   Signal: A GSR TEAPhysio signal

Signal = GSR_new_empty();

Signal.sampFreq = sampFreq; %Hz

if(median(rawGSR) < 1)
	warning(['The signal given seems to be given in Siemens. I need Ohms. ' ...
	         'Automatic conversion applied']);
	rawGSR = 1/rawGSR;
end


Signal.raw = Raw_convert_1D(rawGSR);


end

