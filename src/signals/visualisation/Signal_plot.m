function Signal_plot(Signal, startT, endT)
%Plots a signal: value vs time, between startT and entT
% Inputs:
%  Signal: the sigal to plot
%  startT: the start time, in frames
%  endT: the end time, or 0 if all the signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

raw = Signal_get_raw(Signal);

if(endT ~= 0)
	raw = raw(1:endT);
end

plot(raw);
