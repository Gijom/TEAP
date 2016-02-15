%> @file Signal__set_preproc.m
%> @brief Set a preprocessing attribute for a signal. Ex: lowPass, highPass

%> @param  Signal: the signal
%> @param  preprocName: the name of the preprocessing calculus done

%> @retval  Signal: the modified signal

%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = Signal__set_preproc(Signal, preprocName)

if(nargin ~= 2)
	error('Usage: Signal = Signal__set_preproc(Signal, preprocName)');
end

if(nargout ~= 1)
	error('You need to retrieve the function''s result. Else, it''s useless !');
end


Signal__assert_mine(Signal);

Signal.preprocessing.(preprocName) = true;


