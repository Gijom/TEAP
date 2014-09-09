#These are all the signals actually supported:

##DMY: DONE
	A simple dummy signal for tests, learning how the toolbox works, and co.

##BVP/PLET DONE
	Blood Volume Pressure

##ECG: DONE
	Electrocardiography

##EEG: SEMIDONE
	Electroencephalography

##EMG:
	Electromyography

##EOG:
	Electrooculography

##GSR: DONE
	Galvanic Skin Response (also known as SCR: Skin Conductance Response)

##RES: DONE
	Respiration (also known as HRP: Human Respiration Pattern)

##HST: DONE
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

#CREATING A NEW SIGNAL
If you want to create a new signal (eg. the weight of a person), you can proceed
by copying the DMY signal. If this signal is supported by EEGLab, you should
not forget to add-it to the adapter functions (eg. adapters/Bulk_load_eeglab())
