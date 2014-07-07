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

%!assert(Signal_has_feature(Signal_new_empty(), 'oauoau'), false);

%!test
%! sig = Signal_new_empty();
%! sig = Signal_set_feature(sig, 'aoeu', 42);
%! assert(Signal_has_feature(sig, 'aoeu'), true);
%! assert(Signal_has_feature(sig, 'htns'), false);
