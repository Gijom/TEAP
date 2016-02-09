function BVPSignal = BVP__compute_IBI( BVPSignal )
%Computes the IBI if it is not yet available
% Inputs:
%  BVPSignal: the BVP signal
% Outputs:
%  BVPSignal: the BVP signal containing the computed IBI signal
%
%Copyright Guillaume Chanel 2015

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

