function Signal_plot(Signal, startT, endT)
%Plots a signal: value vs time, between startT and entT.
% Signal_plot(sig); Signal_plot(sig, start); Signal_plot(sig, start, end);
% NOTA BENE: if you want to display a bulk signal instead, use Bulk_plot(Bulk);
% Inputs:
%  Signal: the sigal to plot
%  startT: the start time, in frames (optional)
%  endT: the end time, or 0 if all the signal (optional)
%
%Copyright Frank Villaro-Dixon MIT LICENSE, 2014

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
		Sig_copy = Signal__set_name(Sig_copy, [Signal__get_signame(Signal) ' - ' ...
		                                       fields{i}]);

		Signal_plot(Sig_copy, startT, endT);
	end
	return
else %for 1D signals
	Signal_plot1D(Signal, startT, endT);
end

