function Signal = RES__new_empty()
% Creates a new RES empty signal
% Output:
%  Signal: an empty RES signal.
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

Signal = Signal__new_empty();
Signal = Signal__set_signame(Signal, RES__get_signame());
Signal = Signal__set_unit(Signal, 'µV'); %FIXME

