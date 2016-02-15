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
