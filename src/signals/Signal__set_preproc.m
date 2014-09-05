function Signal = Signal__set_preproc(Signal, preprocName)
%Set a preprocessing attribute for a signal. Ex: lowPass, highPass
% Inputs:
%  Signal: the signal
%  preprocName: the name of the preprocessing calculus done
% Outputs:
%  Signal: the modified signal
%
%Copyright Frank Villaro-Dixon MIT LICENSE, 2014

if(nargin ~= 2)
	error('Usage: Signal = Signal__set_preproc(Signal, preprocName)');
end

if(nargout ~= 1)
	error('You need to retrieve the function''s result. Else, it''s useless !');
end


Signal__assert_mine(Signal);

Signal.preprocessing.(preprocName) = true;


