function Boolean = Signal_has_feature(Signal, featureName)
%Tells if the given signal has the feature featureName,
% Inputs:
%  Signal
%  featureName: the name of the feature (ex: 'mean')
% Outputs:
%  true or false
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

%We want Signal.feats.FEATURE to exist

%Does the signal have some features
if(~isfield(Signal, 'feats'))
	Boolean = false;
	return;
end

%Does it have the feature:
if(~isfield(Signal.feats, featureName))
	Boolean = false;
	return;
end

Boolean = true;
