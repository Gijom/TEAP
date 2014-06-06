#These are all the signals actually supported:

##BVP:
	Blood Volume Pressure

##ECG:
	Electrocardiography

##EEG:
	Electroencephalography

##EMG:
	Electromyography

##EOG:
	Electrooculography

##GSR:
	Galvanic Skin Response

##HRP:
	Human Respiration pattern

##HST:
	Human Skin Temperature (actually, I made that myself)


#The toolbox structure

physioSignal/                The signal (GSR, ECG, …)
	acquisiton/          From device, from file, etc.
	view/                Simple viewing of the signal
	tests/               Tests about the code
