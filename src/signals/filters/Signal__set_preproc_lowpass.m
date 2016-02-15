%> @file Signal__set_preproc_lowpass.m
%> @brief Sets the pre-processing property of low-pass for the signal
%> @param  Signal
%> @retval Signal: the modified signal
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = Signal__set_preproc_lowpass(Signal)

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: Signal = Signal__set_preproc_lowpass(Signal)');
end

Signal = Signal__set_preproc(Signal, 'lowpass');

