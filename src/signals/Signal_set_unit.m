function Signal = Signal_set_unit(Signal, unitStr)
%Sets the unit of a signal
% Inputs:
%  Signal: the signal you want to add the unit to
%  unitStr: the unit name (ex: 'Ohm');
% Outputs:
%  The newly modified signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

Signal.unit = unitStr;
