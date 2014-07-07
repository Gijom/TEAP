function Boolean = Signal_has_preproc(Signal, preprocName)
%Has the given signal been through this preprocessing step
% Inputs:
%  Signal: the signal
%  preprocName: the pre-processing you want
% Outputs:
%  Boolean: a boolean value indicating if yes (1) or no (you guessed-it)
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

%Does the signal have some preprocessing done
if(~isfield(Signal, 'preprocessing'))
	Boolean = false;
	return;
end

%Does it have the feature:
if(~isfield(Signal.preprocessing, preprocName))
	Boolean = false;
	return;
end

Boolean = true;

%!assert(Signal_has_preproc(Signal_new_empty(), 'oauoau'), false);

%!test
%! sig = Signal_new_empty();
%! sig = Signal_set_preproc(sig, 'aoeu');
%! assert(Signal_has_preproc(sig, 'aoeu'), true);
%! assert(Signal_has_preproc(sig, 'htns'), false);
