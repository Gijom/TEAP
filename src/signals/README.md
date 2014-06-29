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
	Galvanic Skin Response (also known as SCR: Skin Conductance Response)

##RES:
	Respiration (also known as HRP: Human Respiration Pattern)

##HST:
	Human Skin Temperature (actually, I made that myself)


#The toolbox structure

physioSignalXXX/                The signal (GSR, ECG, …)
	acquisiton/             From device, from file, etc.
	features/               Getting some features from the signal
	view/                   Simple viewing of the signal
	tests/                  Tests about the code


#Coding conventions
##raw signals
	Raw signals should be given as an horizontal vector (aka. 1xN)
