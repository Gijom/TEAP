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
	error('Usage: Signal_set_feature(signal, featName, featStructure)');
end

if(nargout ~= 1)
	error('You need to retrieve the function''s result. Else, it''s useless !');
end


Signal.feats.(featureName) = featureStructure;

%!error(Signal_set_feature())
%!error(Signal_set_feature(Signal_new_empty(), 'toto', 42)) %no result retreivd
%!assert(Signal_get_feature(Signal_set_feature(Signal_new_empty(), 'to', 42),
%!       'to'), 42)

