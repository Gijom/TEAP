function Signal = Signal_set_feature(Signal, featureName, featureStructure)
%Sets the feature of a given signal.
% Inputs:
%  Signal: the TEAPhysio signal
%  featureName: the feature name (ex: 'mean', 'peaks', etc.)
%  featureStructure: either a scalar (1337.42 or a structure)
% Outputs:
%  The enriched signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 3)
	error('Signal_set_feature needs 3 args (signal, featName, featStructure)');
end


Signal.feats.(featureName) = featureStructure;

