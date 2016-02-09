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

    %Resample the signal with the one requested for IBI
    IBI_samprate = Signal__get_samprate(BVPSignal.IBI);
    IBI = interpIBI(listePeak/samprate,IBI_samprate,listePeak(end)/samprate)';
    
    %Attribute the computed signal to IBI
    BVPSignal.IBI = Signal__set_raw(BVPSignal.IBI,IBI);
end

end

