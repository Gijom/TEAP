function Boolean = Signal_has_preproc_lowpass(Signal)
%Has the signal been low-passed ?
% Inputs:
%  Signal
% Outputs:
%  Boolean: 1: yes
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

Boolean = Signal_has_preproc(Signal, 'lowpass');
