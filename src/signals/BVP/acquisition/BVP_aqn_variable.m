%> @file BVP_aqn_variable.m
%> @brief BVP_aqn_variable gets a BVP signal from a variable

%> @param   rawBVP [1xN]: the raw BVP signal
%> @param    sampRate [1x1]: the sampling rate, in Hz

%> @retval   Signal: A BVP TEAPhysio signal

%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = BVP_aqn_variable(rawBVP, sampRate)

if(nargin ~= 2)
	error('Usage: BVP_aqn_variable(rawBVP, sampRate)');
end


Signal = BVP__new_empty();
Signal = Signal__set_samprate(Signal, sampRate);

Signal = Signal__set_raw(Signal, Raw_convert_1D(rawBVP));

%And we filter the signal. Else, it's useless
Signal = BVP_filter_basic(Signal);

end

