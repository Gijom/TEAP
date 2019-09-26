#TEAPhysio documentation

##Abstract
**TEAPhysio**, the *Toolbox for Emotion Analysis using Physiological signals*,
is a Matlab (fully [Octave](https://gnu.org/software/octave/) compliant) toolbox
that aims to reduce code dispersing and duplication across your research
projects.

TEAP supports various signals (*ECG*, *BVP*, *GSR*, *EEG*, etc.) and it's aim is
to allow the user to quickly use the and compute signal features without any
boilerplate code.  TEAP is also programmed in an OOP sort of way: it is really
easy to program signal feature code or to add another signal structure to the
toolbox.

##Goal of the toolbox
There are actually some toolboxes that allow signal processing (like
[EEGLAB](http://sccn.ucsd.edu/eeglab/), or
[BioSig](http://biosig.sourceforge.net/)), but these where too complex or too
specialized. TEAP solves that offering a somewhat high-level interface (see the
examples below): with some kB of code, you can do some powerful things. The goal
was also too allow a user to easily add signals or functions for a signal
feature extraction.
#Introduction
TEAPhysio is a toolbox. You can also view-it as a library. That is, you can
easily add a specific signal into you workspace and extract it's features using
TEAP.

As you'll see, TEAP is divided into 2 main components: `Signals` and `Bulk
signals`.

A `Signal` may be viewed as a channel from the acquisition card (except for
things like EEG and ECG (which uses 2 differential signals), but these specific
cases are embedded in within the signal).

A `Bulk Signal` can be viewed as the acquisition card: a `Bulk Signal` consists
of multiple signals.

An important thing about TEAP is that TEAP is stateless: that is, each function
works on a variable (mainly structures, but you don't have to know that) and
returns a variable. No global variables or states are used.
##Getting TEAPhysio
The best way to get TEAP is via git: the URL is:

	git://git.vi-di.fr/TEAPhysio.git

so you just have to type:

	git clone git://git.vi-di.fr/TEAPhysio.git
##License
TEAPhysio is licensed under the [BSD 3-Clause
License](http://opensource.org/licenses/BSD-3-Clause). For the exact license,
please take a look at the `LICENSE` file located at the root of the TEAP folder.

##Thanks to
Many thank to *Mohammad Soleymani*, *Guillaume Chanel*, and *Prof. Thierry Pun*
from the [University of Geneva/CVML](http://cvml.unige.ch/), TEAP couldn't have
been developed without their help !
##Contributing to TEAP
If you want to contribute to TEAP, you are encouraged to send git patches (see
[here](
https://ariejan.net/2009/10/26/how-to-create-and-apply-a-patch-with-git/) for
more info) to [TEAP@vi-di.fr](mailto:TEAP@vi-di.fr); they'll be applied upstream

You can also read the `HACKING` and the `CONTRIB` file for more info.
##Terms and abbreviations

* **TEAP**: short for TEAPhysio
* **GSR**: Galvanic Skin Response
* **HST**: Human Skin Temperature

#TEAPhysio utilisation
In the following chapter we'll see how you can simply and efficiently use TEAP.

##Loading TEAP
In order to load TEAPhysio, you have two possibilities, but they all use the
same principle

###TEAPhysio for multiple small projects
If you want to use TEAP for multiple small projects, the best way is to extract
TEAP somewhere and add-it to your matlab's (or octave's) classpath. This way,
TEAP's functions will always be accessible.

###TEAPhysio for a standalone project
If you want to build a project that uses TEAP and that should work everywhere,
the best way is to copy TEAPhysio in your project's folder. Then, you'll simply
have to call the `init.m` scrip to load TEAP.

##Description of TEAP's functions

We can divide TEAP functions into two parts:

* **User functions**: XXX\_YYY\_ZZZ
* **Toolbox functions**: XXX\_\_YYY\_ZZZ

The functions you want to know are the **user functions**, that is the ones that
are useful to you. The toolbox functions (the ones containing *2 trailing
underscores*) are specific to TEAP, and you shouldn't have to use them (except
if you want to add a feature to TEAP).
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

#Signals actually supported by TEAP
Here is the list of signals that are actually supported by TEAP:

You can also read the list at `src/README.md`

##BVP (Blood Volume Pressure)
* BPM
* mean
* std
* var

##ECG (ElectroCardioGram)
* IBImean
* IBIvar

##EEG (ElectroEncephaloGram)
* bandENR

##GSR (Galvanic Skin Response)
* peaks

##HST (Human Skin Temperature)
* mean derivative
* mean

##RES (RESpiration)
* energy
* main frequency
* min/max

##DMY
This is a sample dummy signal, not useful to you, unless you want to contribute
to TEAP a bit ;)


#TEAP code examples
For some examples, you can go to `src/signals/SSS/examples` (*SSS* is the name
of the signal). For example, there is an example here:

	src/signals/GSR/examples/GSR_feat_peaks_example.m
#Technical Information
Here is some technical information, for you geeks or hackers:
##Technical Info: Signals
###Description
Signals are organised in a OOP sort of way: each signal (ex. Galvanic Skin
Response) has their own folder (in our case: `GSR`). Once in this folder, the
functions are ordered by folder (eg: *acquisition*, *examples*, *features*,
*tests*). For example, if you want to capture a Galvanic Skin Response signal,
you would have to call a function in the `GSR/acquisition` folder (for ex:
`GSR_aqn_file()`).

###OOP structure
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

#### pre-processing structure
This structure indicates the possible pre-processing features that the signal
has. Actually, only `lowpass = 1` is sometimes used.

###Complete example
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

##Technical Info: Bulk Signals
###Taking an embedded signal
You could use `Bulk.SIG`, but it's actually a bad practice. Use instead this
simple function:

    Signal = Bulk_get_signal(BulkSig, SSS_get_signame())

`SSS_get_signame()` gives the name of a signal (ex: `GSR_get_signame()` gives
back **'GSR'**).

###Getting the list of the signals of a bulk signal
Well, the function `Bulk_get_signals()` gives a list of all the signals inside
this bulk signal (for you techies, it lists the fields, and takes back the
`TEAPhysio` control field.

###Adding a signal to a bulk signal
If you want to add a signal to a bulk signal, you may want to do:

    Bulk.SSS = SSSsig;

but that is bad :(. Use:

    Bulk = Bulk_add_signal(Bulk, SSS_get_name(), SSSsig);

instead ;)

##Creating your own missing signal

If you want to create a missing TEAP signal (eg: EOG), the best way would be to
copy some signal's folder (eg: `GSR`), and start renaming the names.

Don't forget to rename these things:

* in `SSS__new_empty.m`: the signal's unit
* in `SSS__get_signame.m`: the signal's name. Replace-it by *SSS*

#Conclusion
As you may see, TEAP can be quite simple, yet powerful to use, but there are
still some missing features and signals (eg: *EOG*, *EMG*). I hope that some
persons will contribute to the project, and add some more features to it ;).
