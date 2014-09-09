function Signal_plot1D(Signal, startT, endT)
%Plots a signal: value vs time, between startT and entT.
% Signal_plot1D(sig); Signal_plot1D(sig, start); Signal_plot1D(sig, start, end);
% NOTA BENE: if you want to display a bulk signal instead, use Bulk_plot(Bulk);
% Inputs:
%  Signal: the sigal to plot
%  startT: the start time, in frames (optional)
%  endT: the end time, or 0 if all the signal (optional)
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

raw = Signal__get_raw(Signal);
samprate = Signal__get_samprate(Signal);

name = Signal__get_signame(Signal);
signal_unit = Signal__get_unit(Signal);

if(nargin == 2)
	raw = raw(startT:end);
elseif(nargin == 3)
	if(endT == 0)
		raw = raw(startT:end);
	else
		raw = raw(startT:endT);
	end
end


xes = [1:length(raw)];

seconds = xes / samprate;

plot(seconds, raw);


offset = Signal__get_offset(Signal);

%The signal may be offseted with Signal__get_window. If so, say it
if(offset ~= 0)
	offsetT = offset / samprate;
	xlabel(['Seconds - ' num2str(offsetT) ' (offset)']);
else
	xlabel('Seconds');
end

%The y label title
if(Signal__has_preproc_lowpass(Signal))
	comments = ' (low passed)';
else
	comments = '';
end

ylabel([name ' (' signal_unit ')' comments]);


%The graph title
title([name ' vs Seconds']);


