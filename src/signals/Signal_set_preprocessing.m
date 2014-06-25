function Signal = Signal_set_preprocessing(Signal, preprocName)
%Set a preprocessing attribute for a signal. Ex: lowPass, highPass
% Inputs:
%  Signal: the signal
%  preprocName: the name of the preprocessing calculus done
% Outputs:
%  Signal: the modified signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

Signal.preprocessing.(preprocName) = true;
