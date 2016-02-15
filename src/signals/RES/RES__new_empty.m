%> @file RES__new_empty.m
%> @brief Creates a new RES empty signal
%> @retval  Signal: an empty RES signal.
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = RES__new_empty()

Signal = Signal__new_empty();
Signal = Signal__set_signame(Signal, RES__get_signame());
Signal = Signal__set_unit(Signal, 'uV');

