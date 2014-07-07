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

%Make sure we have a TEAPhysio signal
Signal_assert_mine(Signal);

if(isfield(Signal, 'feats'))
	if(isfield(Signal.feats, featureName))
		feature = Signal.feats.(featureName);
		return;
	end
	error(['The signal hasn''t got the feature ' featureName]);
end

error('The signal hasn''t got any features');

%!error(Signal_get_feature())
%!error(Signal_get_feature(42))
%!error(Signal_get_feature(42, 'toto'))

%!test
%! sig = Signal_new_empty();
%! sig.feats.test = 42;
%! assert(Signal_get_feature(sig, 'test'), 42);

