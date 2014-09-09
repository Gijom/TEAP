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

