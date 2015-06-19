function [IBI,HR,t] = interpIBI(peaks,fs,duration, silent)
% function [IBI,HR,t] = interpIBI(peaks,fs,duration)
% 
% This function interpolate an HR/IBI signal (from a list of peaks) with the
% method proposed in:
%       Berger et al., "An Efficient Algorithm for Spectral Analysis of
%       Heart Rate Variability", IEEE Trans. on Biomedical Engineering,
%       Vol. 33, No. 9, sept. 1986
% 
% IN:
% 
%   peaks: a list of R peaks expressed in seconds (e.g. [0.3 1.4 2.3 3.2])
%   
%   fs : sampling frequency desired for the interpolated HR/IBI signal
% 
%   duration : duration desired. Concerning time aspects, the first sample
%   is assumed to lie at time 1/fs (which can be before the first peak) and
%   the last at time 'duration'. If point in time that are not computable
%   because of lack of peaks (beginning and end of the output signals), they are
%   simply padded with the closest computed value.
% 
% OUT:
% 
%   IBI [1*N]: N interbeat intervals (in seconds)
% 
%   HR [1*N]: N heart rate values
% 
%   t [1*N]; N time stamps corresponding to the IBI and HR values
% 
% Author: Guillaume Chanel
% Date: 7/12/2009

if(nargin < 4)
    silent = 0;
end

%construction of time vector (starting at t=1/fs up to duration, with fs
%sampling rate) and corresponding HR vector
t = [1/fs:1/fs:duration]';
nbSpl = length(t);
HR = zeros(nbSpl,1);

%Construction of the uneven sampled IBI vector (to be replaced in the end)
IBI = diff(peaks);

% Define the first and last sample for HR computation : it starts 2 samples
% after the first peak and stop 2 samples before the last peak. This is
% necessary to have a full window for HR computation
firstSpl = find(t > peaks(1));
firstSpl = firstSpl(2);
lastSpl = find(t < peaks(end));
lastSpl = lastSpl(end-2);
if(isempty(lastSpl))
    lastSpl = nbSpl;
end

% First the first computable to the last computable samples:
% compute the HR values !
for(i=firstSpl:lastSpl)
    %Definition of boundaries of interval used for HR computation
    minT = t(i-1);
    maxT = t(i+1);
    
    %Identify the peaks that are present in the current interval
    pInt = (peaks > minT) & (peaks < maxT);
    nbP = sum(pInt);
    
    %Depending on the differents cases:
    if(nbP < 1) % no peaks in the current interval
        %Find the unique IBI that correspond to the current time
        idxIBI = find(peaks > t(i));
        idxIBI = max(idxIBI(1)-1,1);
        
        %Update HR
        HR(i) = 1/IBI(idxIBI);
        
    else %At least one peak in the current interval
        %Send waring if more than one peak in an interval
        if((nbP > 1) && ~silent) %more than one peak in an interval
            warning([num2str(nbP) ' peaks were found in an interval -> consider increasing frequency']);
        end
        
        %Compute the number of peaks (sum of IBI before peaks + IBI after
        %the last peak)
        idxPeaks = find(pInt);
        nbPeaks = 0;
        for(iP = idxPeaks)
            nbPeaks = nbPeaks + (peaks(iP)-max(minT,peaks(iP-1)))/IBI(iP-1);
        end
        nbPeaks = nbPeaks + (maxT-peaks(idxPeaks(end)))/IBI(idxPeaks(end)); %add IBI after the last peak
        
        %Update HR
        HR(i) = fs*nbPeaks/2;
        
        
    end
end

%Fill begining and ending values with the first and last computed HR
HR(1:firstSpl) = HR(firstSpl);
HR(lastSpl:end) = HR(lastSpl);

%Compute IBI
IBI = 1./HR;