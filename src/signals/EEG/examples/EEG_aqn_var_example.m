AF3 = csvread('outFile_signal_AF3')';
F3 = csvread('outFile_signal_F3')';
Fp1 = csvread('outFile_signal_Fp1')';

electrodes = [AF3; F3; Fp1];

sig = EEG_aqn_variable(['AF3'; 'F3'; 'Fp1'], electrodes, 1024);


