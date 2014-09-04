function Signal = GSR_aqn_variable(rawGSR, sampRate)
% GSR_aqn_variable gets a GSR signal from a variable
% Inputs:
%   rawGSR [1xN]: the raw GSR signal
%   sampRate [1x1]: the sampling rate, in Hz
% Outputs:
%   Signal: A GSR TEAPhysio signal
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 2)
	error('Usage: GSR_aqn_variable(rawGSR, sampRate)');
end


Signal = GSR__new_empty();
Signal = Signal__set_samprate(Signal, sampRate);

%If it is given in Siemens
if(min(rawGSR) >= 0 && max(rawGSR) < 1)
	warning(['The signal given seems to be given in Siemens. I need Ohms. ' ...
	         'Automatic conversion applied']);
	rawGSR = 1./rawGSR;
elseif(min(rawGSR) < 0) %if the signal was baselined/relatived
	Signal = Signal__set_absolute(Signal, false);
end


Signal = Signal__set_raw(Signal, Raw_convert_1D(rawGSR));

%And we filter the signal. Else, it's useless
Signal = GSR_filter_basic(Signal);

end

