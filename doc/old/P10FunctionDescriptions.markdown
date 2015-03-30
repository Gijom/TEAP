#Description of how the functions work

There are two types of functions: `Signal_…` and `Bulk_…`. In general, 
***Signal*** functions work on simple signal (ex: EEG, ECG, ect.). ***Bulk*** 
functions work on bulk signals (that is, the ones that contain embedded 
**signals**).

##General signal functions
Signal functions that are general (ie. not specific to a signal) are generally 
named like that:

    Signal_FFF_OOO

`FFF` is the function. It can be one of the following:

1. `feat` for general features
2. `get` for parameter getting
3. `set` for parameter setting
3. `assert` for asserting things
4. `filter1` for 1D filtering
5. etc.

`OOO` is the function's object, ie what the function does.


##Specific signal functions

