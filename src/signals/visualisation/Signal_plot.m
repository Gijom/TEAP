function Signal_plot(Signal, startT, endT)
%Plots a signal: value vs time, between startT and entT.
% Signal_plot(sig); Signal_plot(sig, start); Signal_plot(sig, start, end);
% Inputs:
%  Signal: the sigal to plot
%  startT: the start time, in frames (optional)
%  endT: the end time, or 0 if all the signal (optional)
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

raw = Signal_get_raw(Signal);
samprate = Signal_get_samprate(Signal);
name = Signal_get_signame(Signal);
signal_unit = Signal_get_unit(Signal);

if(nargin == 2)
	raw = raw(startT:end);
elseif(nargin == 3)
	raw = raw(startT:endT);
end


xes = [1:length(raw)];

seconds = xes / samprate;

plot(seconds, raw);


offset = Signal_get_offset(Signal);

%The signal may be offseted with Signal_get_window. If so, say it
if(offset ~= 0)
	offsetT = offset / samprate;
	xlabel(['Seconds - ' num2str(offsetT) ' (offset)']);
else
	xlabel('Seconds');
end

ylabel([name ' (' signal_unit ')']);
title([name ' vs Seconds']);


