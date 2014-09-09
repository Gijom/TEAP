###TEAP user functions
####Signals
As we saw, User functions are the ones that you be useful to you. Here are the 
different possible user functions:

* `SSS_feat_FFF`: calculates the feature *FFF* for a signal of type *SSS*. Ex: 
  `BVP_feat_BPM(BVPSig)`. Please note that there also are some general 
  functions, ex: `Signal_feat_enr()`, that apply to all signals.
* `SSS_aqn_TTT`: creates a TEAPhysio *SSS* signal from something. *TTT* can be 
  `variable`. In this case, creates a signal *SSS* from a variable. Ex: 
  `GSR_aqn_variable(data, fs)`.
* `Signal_plot`: plots a signal, with good axis and co.
* `Signal_plot_pts`: plots points onto the graph. Divides by the sampling rate, 
  so you read seconds.


####Bulk Signals
As you may see, there are fewer bulk signal functions than signal functions.  
This is because bulk signal functions are only used to create the bulk signal.  
When you want to calculate things, you do it on signals.

Here are the two main functions:

* `Bulk_load_PPP`: loads a bulk signal from something. Ex: `Bulk_load_eeglab()` 
  to load a bulk signal from an ecglab variable.
* `Bulk_plot`: plots all the bulk signal (calls `Signal_plot` on each of it's 
  signals).
