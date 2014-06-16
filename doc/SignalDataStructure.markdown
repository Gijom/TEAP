#Signal data structure of the TEAP toolbox

##Description
Signals are organised on a OOP sort of way: each signal (ex. Galvanic Skin 
Response) has their own folder (in our case: GSR). Once in this folder, the 
functions are ordered by folder (eg: acquisition, examples, features, tests, 
baselines). If you want to capture a Galvanic Skin Response signal, you would 
have to call a function in the GSR/acquisition folder (for ex: GSR_aqn_file).

##OOP structure
Signals of the TEAP toolbox are in fact structures. The signal has the following 
attributes embedded:
* name: the signal name (ex: GSR)
* raw: the raw signal acquired from the device
* sampFreq: the sampling frequency of the signal (in Hz)
* feats: a sub structure containing the features of the signal

You should *always* access to the signal's attributes via the signal's 
functions. These functions are fail-safed, an guarantee a semantic coherence 
across the variables: you can't call GSR_feat_median(Sig1) when Sig1 is of type 
ECG.


##Signal features
Please note that once a signal is acquired, it's features are NOT automatically 
calculated. When you call a feature getter on a signal, if this feature wasn't 
calculated previously, it will be calculated; else, it will only be returned.

