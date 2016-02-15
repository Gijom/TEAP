##Using the TEAP functions
Here's a short example (more examples below) of how to use TEAP:

###Signals
####Creating/acquiring a signal
Let's say that you have a raw signal in a variable. You then want to create a 
signal to be able to extract it's features. Here's what you have to do, using a 
*BVP* signal for the sake of simplicity:

	MyBVPSig = BVP_aqn_variable(BVP_raw_signal, raw_sig_sampfreq);

Please note that in most cases, the function filters the signal (with a mean, 
median or filter, depending on the signal), so you don't have to do-it yourself.

####Filtering the signal
Supposing you would want to filter the signal a bit more (but you surely don't 
want to), you would have to do (supposing a median filter):

	MyBVPSig = Signal__filter1_low_median(MyBVPSig, winSize);

As you can see, you have to get the result into the same variable, or else it 
won't be modified.

####Displaying the signal
If you want to display the given signal, you only have to type:

	Signal_plot(MyBVPSig);

####Calculating a feature
To calculate a feature, supposing that you know the features supported by the 
signal (If you don't, in matlab/octave, type: `BVP_feat_<TAB>`, it'll give you a 
list), simply type:

	BVP_feat_BPM(MyBVPSig)



###Bulk signals
####Creating a bulk signal
Let's say that you want to import an eeglab bulk signal:

	load myBigMat.mat
	Bulk = Bulk_load_ecglab(EEG);

and that's it.

**Please note** that `Bulk` is now an array ! If you only want to work with the 
first epoch, do:

	epoch1 = Bulk(1);

####Displaying the bulk signal
To display the bulk signal:

	Bulk_plot(Bulk);

This will display a figure per epoch. If you only want to display the first 
epoch, do:

	Bulk_plot(Bulk(1));


####Calculating features
Bulk signals contain signals. If you want to calculate the BPM from a *BVP* 
signal, you can do-it in 2 ways:

	BVPSig = Bulk.BVP;
	BVP_feat_BPM(BVPSig);

But TEAP is clever. If a bulk signal contains only one signal of the type you 
want, you can directly do:

	BVP_feat_BPM(Bulk);

