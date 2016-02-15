%> @brief RES_aqn_variable gets a RES signal from a variable

%> @param rawRES [1xN]: the raw RES signal
%> @param sampRate [1x1]: the sampling rate, in Hz

%> @retval Signal: A RES TEAPhysio signal
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = RES_aqn_variable(rawRES, sampRate)

if(nargin ~= 2)
	error('Usage: RES_aqn_variable(rawRes, sampRate');
end

Signal = RES__new_empty();
Signal = Signal__set_samprate(Signal, sampRate);

Signal = Signal__set_raw(Signal, Raw_convert_1D(rawRES));

%And we filter the signal. Else, it's useless
Signal = RES_filter_basic(Signal);


end

