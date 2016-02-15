%> @brief Has the given signal been through this preprocessing step
%> @param  Signal: the signal
%> @param preprocName: the pre-processing you want
%> @retval  Boolean: a boolean value indicating if yes (1) or no (you guessed-it)
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Boolean = Signal__has_preproc(Signal, preprocName)

%Does the signal have some preprocessing done ?
if(~isfield(Signal, 'preprocessing')) %No preprocessing whatsoever
	Boolean = false;
	return;
end

%Does it have the feature:
if(~isfield(Signal.preprocessing, preprocName))
	Boolean = false;
	return;
end

Boolean = true;

%!assert(Signal__has_preproc(Signal__new_empty(), 'oauoau'), false);

%!test
%! sig = Signal__new_empty();
%! sig = Signal__set_preproc(sig, 'aoeu');
%! assert(Signal__has_preproc(sig, 'aoeu'), true);
%! assert(Signal__has_preproc(sig, 'htns'), false);
