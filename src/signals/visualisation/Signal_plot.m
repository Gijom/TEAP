%> @file Signal_plot.m
%> @brief Plots a signal: value vs time, between startT and entT.
%> @c Signal_plot(sig); @c Signal_plot(sig, start); @c Signal_plot(sig, start, end);
%> @attention NOTA BENE: if you want to display a bulk signal instead, use Bulk_plot(Bulk);

%> @param  Signal: the sigal to plot
%> @param  startT: the start time, in frames (optional)
%> @param  endT: the end time, or 0 if all the signal (optional)
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal_plot(Signal, startT, endT)

raw = Signal__get_raw(Signal);

if(nargin < 2)
	startT = 1;
	endT = 0;
elseif(nargin < 3)
	endT = 0;
end

%mainly for EEG
if(strcmp(typeinfo(raw), 'matrix') == 0)
	figure; %FIXME: embed within
	%use things like parent=axes('Parent'); or things like that

	fields = fieldnames(raw);
	sq = ceil(sqrt(size(fields, 1)));
	for i = [1:size(fields)]
		subplot(sq, sq, i);

		%This is a copy !
		Sig_copy = Signal__set_raw(Signal, raw.(fields{i}));
		Sig_copy = Signal__set_signame(Sig_copy, [Signal__get_signame(Signal) ' - ' ...
		                                       fields{i}]);

		Signal_plot(Sig_copy, startT, endT);
	end
	return
else %for 1D signals
	Signal_plot1D(Signal, startT, endT);
end

