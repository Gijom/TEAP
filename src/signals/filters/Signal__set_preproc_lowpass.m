function Signal = Signal__set_preproc_lowpass(Signal)
%Sets the pre-processing property of low-pass for the signal
% Inputs:
%  Signal
% Outputs:
%  Signal: the modified signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: Signal = Signal__set_preproc_lowpass(Signal)');
end

Signal = Signal__set_preproc(Signal, 'lowpass');

