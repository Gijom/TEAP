function GSRsignal = GSR_filter_basic(GSRsignal, cutOffFreq)
%Cleans a signal adding a low-pass filter to it
% Inputs:
%  GSRsignal: the GSR signal.
%  cutOffFreq: the cutOff frequency for the filter. Default is 100Hz

% Outputs:
%  Signal: the filtered GSR signal
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014


%Make sure we have a GSR signal
GSR_assert_type(GSRsignal)


%Default cutoff
if(nargin < 2)
	cutOffFreq = 100; %Hz
end

GSRsignal = Signal_filter_low1D(GSRsignal, cutOffFreq);
