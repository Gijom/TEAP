%> @file Signal__assert_range.m
%> @brief Asserts that the signal is a TEAPhysio one

%> @param  Signal: the signal to test
%> @param  minVal: the minimum value (default to -Inf)
%> @param  maxVal: the maximum value (defaults to +Inf)
%> @param  soft: boolean indicating if the assert is soft (i.e. 1 -> warning) or hard (i.e. 0 -> error), defaults to 0
%
%> @author Copyright Guillaume Chanel, BSD Simplified, 2016
function Signal__assert_range(Signal, minVal, maxVal, soft)

if(nargin > 4 || nargin < 2)
	error('Usage: Signal__assert_mine(Signal)');
end

if(nargin < 2)
	minVal = -Inf;
end

if(nargin < 3)
	maxVal = +Inf;
end

if(nargin < 4)
	soft = 0;
end

%Check the range of signals and construct potential warning/error
%message
msg = '';
minSig = min(Signal__get_raw(Signal));
if(minSig < minVal )
	msg = [msg 'The value ' num2str(minSig) ' is too low for ' Signal__get_signame(Signal) ' signals (min = ' num2str(minVal) '). '];
end


maxSig = max(Signal__get_raw(Signal));
if(maxSig > maxVal)
	msg = [msg 'The value ' num2str(maxSig) ' is too high for ' Signal__get_signame(Signal) ' signals (max = ' num2str(maxVal) '). '];
end

if(soft == 1)
	warning([msg 'This might lead to other warnings']);
else
    error(msg);
end

