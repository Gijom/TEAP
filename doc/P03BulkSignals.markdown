#BULK SIGNALS

##What are Bulk Signals ?

Sometimes, when you research something, you may have to record many channels 
(EEG, GSR, etc.) for each experiment. It would be fine to have a variable per 
channel, but it would be cumbersome if you had 10 participants. One way would be 
to deal with a cell array or something, but that's work you shouldn't have to 
do.

Bulk Signals are simply structures with all the channels embedded within. Let's 
say you want to import a recording of a participant (loaded from a `.mat` file).  
You only have to type something like:

    load Participant01_t01.mat
    P01t01 = Bulk_load_mat(REC);

and the variable `P01t01` would then be a bulk signal.

If you are curious about how a Bulk signal works: it's simply a structure. Each 
signal has it's own field (the **GSR** signal is embedded in the `.GSR` field, 
etc.).  There is also an extra 'validity-check' field, named `.TEAPhysio`, which 
consists of a single value: **'B'**, to indicate that this variable is a Bulk 
signal.

##How to use bulk signals, you would ask ?

Well, we think it's fairly simple. Let's take an example. Imagine that you have 
a **GSR** signal and you want to calculate it's peaks. With this single signal, 
you only have to write: `GSR_feat_peaks(GSRSig)`.

Now, as you have to deal with multiple signals, you have a bulk signal (let it 
be named `aBS` (for 'a Bulk Signal', or 'Anti …' if you are humorous). You would 
think you would have to type `GSR_feat_peaks(aBS.GSR)` (that's a BAD practice, 
see down below why) to calculate the feature, and it would work, but TEAP is 
clever: the function knows that it needs a **GSR** signal. So if you give it a 
Bulk signal, it will search inside it, and, if a **GSR** signal is embedded 
within, will actually take-it. So `GSR_feat_peaks(aBS)` will work too.





##PROGRAMMING GOOD PRACTICES
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


