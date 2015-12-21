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
    rawSignal = Signal__get_raw(BVPSignal);
    samprate = Signal__get_samprate(BVPSignal);

    %Compute IBI
    newfs = 256; %Hz, as needed by rpeakdetect
    BVP = resample(rawSignal, newfs, samprate); %WARN what happens if samprate/newfs is not a integer ?
    BVP = detrend(BVP);
    [hrv, R_t, R_amp, R_index, S_t, S_amp] = rpeakdetect(BVP', newfs);
    [~, IBI, ~, listePeak] = correctBPM(R_index, newfs);
    
    %Resample the signal with the one requested for IBI
    IBI_samprate = Signal__get_samprate(BVPSignal.IBI);
    IBI = interpIBI(listePeak/newfs,IBI_samprate,listePeak(end)/newfs)';
    
    %Attribute the computed signal to IBI
    BVPSignal.IBI = Signal__set_raw(BVPSignal.IBI,IBI);
end

end

