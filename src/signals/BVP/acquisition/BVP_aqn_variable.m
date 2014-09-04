function Signal = BVP_aqn_variable(rawBVP, sampRate)
% BVP_aqn_variable gets a BVP signal from a variable
% Inputs:
%   rawBVP [1xN]: the raw BVP signal
%   sampRate [1x1]: the sampling rate, in Hz
% Outputs:
%   Signal: A BVP TEAPhysio signal
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 2)
	error('Usage: BVP_aqn_variable(rawBVP, sampRate)');
end


Signal = BVP_new_empty();
Signal = Signal_set_samprate(Signal, sampRate);

Signal = Signal_set_raw(Signal, Raw_convert_1D(rawBVP));

%And we filter the signal. Else, it's useless
Signal = BVP_filter_basic(Signal);

end

