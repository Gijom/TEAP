function Signal = RES_new_empty()
% Creates a new RES empty signal
% Output:
%  Signal: an empty RES signal.
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

Signal = Signal__new_empty();
Signal = Signal__set_name(Signal, RES_get_signame());
Signal = Signal__set_unit(Signal, 'µV'); %FIXME

