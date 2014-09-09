#Technical Info: Signals
##Description
Signals are organised in a OOP sort of way: each signal (ex. Galvanic Skin 
Response) has their own folder (in our case: `GSR`). Once in this folder, the 
functions are ordered by folder (eg: *acquisition*, *examples*, *features*, 
*tests*). For example, if you want to capture a Galvanic Skin Response signal, 
you would have to call a function in the `GSR/acquisition` folder (for ex: 
`GSR_aqn_file()`).

##OOP structure
Signals of the TEAP toolbox are in fact structures. The signal has the following 
attributes embedded:

* `TEAPhysio`: the signal type. Will always be **S** for a signal.
* `samprate`: the sampling rate of the signal.
* `raw`: the raw data of the signal. It's a 1D horizontal vector.
* `unit`: the unit of the signal (ex: *Ohm*).
* `name`: the signal's name (ex: *GSR*)
* `isAbsolute`: indicates if the signal was baselined/relatived.
* `preprocessing`: a vector of pre-processing features (see below).

You should **always** access to the signal's attributes via the signal's 
functions. These functions are fail-safed, and guarantee a semantic coherence 
across the variables: you can't call `GSR_feat_median(Sig1)` when `Sig1` is of 
type ECG.

### pre-processing structure
This structure indicates the possible pre-processing features that the signal 
has. Actually, only `lowpass = 1` is sometimes used.

##Complete example
Here is a little example of a complete signal showing features and 
pre-processing markers:
	GSRsig =
	
	  scalar structure containing the fields:
	
	    TEAPhysio = S
	    samprate =  512
	    raw = SNIP
	    unit = Ohm
	    name = GSR
	    isAbsolute = 0
	    preprocessing =
	
	      scalar structure containing the fields:
	
	        lowpass =  1

