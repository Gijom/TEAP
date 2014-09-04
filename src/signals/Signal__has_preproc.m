function Boolean = Signal__has_preproc(Signal, preprocName)
%Has the given signal been through this preprocessing step
% Inputs:
%  Signal: the signal
%  preprocName: the pre-processing you want
% Outputs:
%  Boolean: a boolean value indicating if yes (1) or no (you guessed-it)
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

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
