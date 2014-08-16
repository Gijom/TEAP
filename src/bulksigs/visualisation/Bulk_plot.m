function Bulk_plot(BulkSig)
%Plots a bulk signal: for each signal of the bulk signal, creates a figure and
%displays the signal
% Inputs:
%  BulkSig: the bulk signal
% Outputs:
%  NONE
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

Bulk_assert_mine(BulkSig);

Signals = Bulk_get_signals(BulkSig);

nsigs = size(Signals);
nsigs = nsigs(1); %the number of signals we have

nsubplots = ceil(sqrt(nsigs)); %The number of subplots we have. Not efficient…




for isig = [1:nsigs]
	SignalStr = Signals(isig, :);
	Signal = Bulk_get_signal(BulkSig, SignalStr);
	subplot(nsubplots, nsubplots, isig);
	Signal_plot(Signal);
end


