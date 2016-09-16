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
% 
%> @file BVP__compute_IBI.m
%> @brief Computes the IBI if it is not yet available
%> @param  BVPSignal: the BVP signal
%> @retval  BVPSignal: the @b BVP signal containing the computed IBI signal
%
%> @author Copyright Guillaume Chanel 2015
function BVPSignal = BVP__compute_IBI( BVPSignal )

%Compute the signal if it has not been already computed
if(isempty(Signal__get_raw(BVPSignal.IBI)))
	
	%Get information on the BVP signal
	BVP = Signal__get_raw(BVPSignal);
	samprate = Signal__get_samprate(BVPSignal);

	%Reshape BVP if needed
	if size(BVP,1)<size(BVP,2)
		BVP = BVP';
	end	

	%Remove trend for better peak detection
	trend = smooth(BVP,samprate); % TODO: refine the window size ? This size seem to wok well thanks to Mohammad
	BVP = BVP - trend;

	%Compute IBI
	[~, ~, ~, listePeak] = PLETtoBPM(-BVP, samprate); %Negation of signal to find the systolic upstroke
	[~, IBI, ~, listePeak] = correctBPM(listePeak, samprate);

	if(length(listePeak) < 2)
		warning(['A least 2 peaks are needed to compute IBI but ' num2str(length(listePeak)) ' were found: result will be NaN'])
		BVPSignal.IBI = Signal__set_raw(ECGSignal.IBI,IBI);
		return
	else

	%Attribute the computed signal to IBI to check if range is correct
	% This is done now because this can cause problems in the resampling
	BVPSignal.IBI = Signal__set_raw(BVPSignal.IBI,IBI);
	Signal__assert_range(BVPSignal.IBI, 0.25, 1.5, 1);

	%Resample the signal with the one requested for IBI
	IBI_samprate = Signal__get_samprate(BVPSignal.IBI);
	IBI = interpIBI(listePeak/samprate,IBI_samprate,listePeak(end)/samprate)';

	%Attribute the computed signal to IBI
	BVPSignal.IBI = Signal__set_raw(BVPSignal.IBI,IBI);
end

end

