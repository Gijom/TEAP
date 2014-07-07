function Signal = RES_aqn_variable(rawRES, sampRate)
% RES_aqn_variable gets a RES signal from a variable
% Inputs:
%   rawRES [1xN]: the raw RES signal
%   sampRate [1x1]: the sampling rate, in Hz
% Outputs:
%   Signal: A RES TEAPhysio signal

if(nargin ~= 2)
	error('Usage: RES_aqn_variable(rawRes, sampRate');
end

Signal = RES_new_empty();
Signal = Signal_set_samprate(Signal, sampRate);

Signal = Signal_set_raw(Signal, Raw_convert_1D(rawRES));


end

