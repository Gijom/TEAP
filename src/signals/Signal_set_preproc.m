function Signal = Signal_set_preproc(Signal, preprocName)
%Set a preprocessing attribute for a signal. Ex: lowPass, highPass
% Inputs:
%  Signal: the signal
%  preprocName: the name of the preprocessing calculus done
% Outputs:
%  Signal: the modified signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 2)
	error('Usage: Signal = Signal_set_preproc(Signal, preprocName)');
end

if(nargout ~= 1)
	error('You need to retrieve the function''s result. Else, it''s useless !');
end


Signal_assert_mine(Signal);

Signal.preprocessing.(preprocName) = true;


