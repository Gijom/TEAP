function feature = Signal_get_feature(Signal, featureName)
%Gets the specified feature of a Signal
% Inputs:
%  Signal
%  featureName: the feature you want
% Outputs:
%  feature: the wanted feature
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 2)
	error('Usage: feature = Signal_get_feature(Signal, featureName)');
end

Signal_assert_mine(Signal);

feature = Signal.feats.(featureName);
