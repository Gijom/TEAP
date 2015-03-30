function Boolean = Signal__has_preproc_lowpass(Signal)
%Has the signal been low-passed ?
% Inputs:
%  Signal
% Outputs:
%  Boolean: 1: yes
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

Boolean = Signal__has_preproc(Signal, 'lowpass');
