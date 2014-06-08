#These are all the signals actually supported:

##DMY:
	A simple dummy signal for tests, learning how the toolbox works, and co.

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

physioSignalXXX/                The signal (GSR, ECG, …)
	acquisiton/             From device, from file, etc.
	features/               Getting some features from the signal
	view/                   Simple viewing of the signal
	tests/                  Tests about the code
