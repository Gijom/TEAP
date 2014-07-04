function Signal = Signal_set_name(Signal, nameStr)
%Sets the name of a signal (ex: 'GSR', 'ECG', etc…) you should NOT use this function,
%only TEAPhysio uses-it
% Inputs:
%  Signal: the signal you want to set the name
%  nameStr: the name string
% Outputs:
%  Signal: the modified signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 2)
	error('Usage: Signal = Signal_set_name(Signal, nameStr)');
end

Signal_assert_mine(Signal);


Signal.name = nameStr;

