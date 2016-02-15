%> @file Signal__set_absolute.m
%> @brief Sets the data of the signal to absolute or relative
%>
%> Example: for a HST signal, do you have samples like [37, 37.5, 37.6] or more
%> like [0, 0.5, 0.6] ? If true, the data is absolute (37), if false, it is relative (0).

%> @param  Signal: the signal to set the flag
%> @param  isAbsolute: true/false

%> @retval  Signal: the same signal with the flag set
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function [Signal] = Signal__set_absolute(Signal, isAbsolute) 

if(nargin ~= 2 || nargout ~= 1)
	error('Usage: Signal = Signal__set_absolute(Signal, isAbsolute)');
end

Signal.isAbsolute = isAbsolute;


