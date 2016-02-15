%> @file Signal__get_absolute.m
%> @brief Is the signal data absolute or relative ?
%> @param  Signal
%> @retval  isAbsolute: true/false depending on if it is absolute (true) or relative
%>              (false) data.
%
%> @attention SEE ALSO:
%> - Signal__set_absolute
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function [isAbsolute] = Signal__get_absolute(Signal)

if(nargin ~= 1)
	error('Usage: isAbsolute = Signal__get_absolute(Signal)');
end

isAbsolute = Signal.isAbsolute;


