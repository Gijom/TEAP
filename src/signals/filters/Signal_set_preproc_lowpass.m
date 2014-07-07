function Signal = Signal_set_preproc_lowpass(Signal)
%Sets the pre-processing property of low-pass for the signal
% Inputs:
%  Signal
% Outputs:
%  Signal: the modified signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014


Signal = Signal_set_preproc(Signal, 'lowpass');

