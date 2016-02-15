%> @file Bulk_plot.m
%> @brief Plots a bulk signal: for each signal of the bulk signal, creates a figure and
%> displays the signal

%> @param  BulkSig the bulk signal
%> @param title the optional title

function Bulk_plot(BulkSig, title)
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014


%IF MULTIPLE EPOCHS
if(size(BulkSig, 2) ~= 1)
	warning(['Displaying all the epochs (=' num2str(size(BulkSig, 2)) ')']);
	for i = [1:size(BulkSig, 2)]
		title = ['Epoch ' num2str(i)];
		Bulk_plot(BulkSig(i), title);
	end
	return;
end

%IF ONE EPOCH
Bulk_assert_mine(BulkSig);

Signals = Bulk_get_signals(BulkSig);

nsigs = size(Signals);
nsigs = nsigs(1); %the number of signals we have

nsubplots = ceil(sqrt(nsigs)); %The number of subplots we have. Not efficient…

if(nargin == 1)
	title = 'Bulk signal';
end

figure('name', title);

for isig = [1:nsigs]
	SignalStr = Signals(isig, :);
	Signal = Bulk_get_signal(BulkSig, SignalStr);
	subplot(nsubplots, nsubplots, isig);
	Signal_plot(Signal);
end


