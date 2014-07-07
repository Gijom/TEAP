function Signal = Signal_rm_features(Signal)
%Removes the features of a signal; useful if the given signal changes (after a
%filter, for example)
% Inputs:
%  Signal: the signal
% Outputs:
%  Signal: the virgin signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 1)
	error('Usage: Signal_rm_features(Signal)');
end

if(nargout ~= 1)
	error('You need to retrieve the function''s result. Else, it''s useless !');
end

Signal_assert_mine(Signal);

if(isfield(Signal, 'feats'))
	Signal = rmfield(Signal, 'feats');
end

%!error(Signal_rm_feature())
%!error(Signal_rm_feature(Signal_new_empty())) %no result retreived
%!assert(Signal_has_feature(Signal_rm_features(Signal_set_feature(
%!        Signal_new_empty(), 'toto', 42)), 'toto'), false)

