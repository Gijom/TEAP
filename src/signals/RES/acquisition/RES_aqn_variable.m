function Signal = RES_aqn_variable(rawRES, sampFreq)
% RES_aqn_variable gets a RES signal from a variable
% Inputs:
%   rawRES [1xN]: the raw RES signal
%   sampFreq [1x1]: the sampling rate, in Hz
% Outputs:
%   Signal: A GSR TEAPhysio signal

Signal = RES_new_empty();
Signal = Signal_set_samprate(Signal, sampFreq);

if(median(rawGSR) < 1)
	warning(['The signal given seems to be given in Siemens. I need Ohms. ' ...
	         'Automatic conversion applied']);
	rawGSR = 1/rawGSR;
end


Signal = Signal_set_raw(Signal, Raw_convert_1D(rawGSR));


end

