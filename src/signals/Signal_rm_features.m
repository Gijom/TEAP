function Signal = Signal_rm_features(Signal)
%Removes the features of a signal; useful if the given signal changes (after a
%filter, for example)
% Inputs:
%  Signal: the signal
% Outputs:
%  Signal: the virgin signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

Signal = rmfield(Signal, 'feats');
