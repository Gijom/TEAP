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
