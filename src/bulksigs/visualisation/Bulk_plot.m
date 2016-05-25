%This file is part of TEAP.
%
%TEAP is free software: you can redistribute it and/or modify
%it under the terms of the GNU General Public License as published by
%the Free Software Foundation, either version 3 of the License, or
%(at your option) any later version.
%
%TEAP is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%GNU General Public License for more details.
%
%You should have received a copy of the GNU General Public License
%along with TEAP.  If not, see <http://www.gnu.org/licenses/>.

%> @file Bulk_plot.m
%> @brief Plots a bulk signal: for each signal of the bulk signal, creates a figure and
%> displays the signal

%> @param  BulkSig the bulk signal
%> @param title the optional title

function Bulk_plot(BulkSig, title)
%Copyright Frank Villaro-Dixon, 2014


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


