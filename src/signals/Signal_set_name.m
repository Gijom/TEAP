function Signal = Signal_set_name(Signal, nameStr)
%Sets the name of a signal (ex: 'GSR', 'ECG', etc…) you should NOT use this function,
%only TEAPhysio uses-it
% Inputs:
%  Signal: the signal you want to set the name
%  nameStr: the name string
% Outputs:
%  Signal: the modified signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 2)
	error('Usage: Signal = Signal_set_name(Signal, nameStr)');
end

if(nargout ~= 1)
	error('You need to retrieve the function''s result. Else, it''s useless !');
end

Signal_assert_mine(Signal);


Signal.name = nameStr;

%!error(Signal_set_name())
%!error(Signal_set_name(42))
%!error(Signal_set_name(42, 43))
%!error(Signal_set_name(Signal_new_empty(), 'hallo')) %no result retreived
%!assert(Signal_get_name(Signal_set_name(Signal_new_empty(), 'gcr')), 'gcr')

