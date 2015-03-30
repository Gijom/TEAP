##Creating your own missing signal

If you want to create a missing TEAP signal (eg: EOG), the best way would be to 
copy some signal's folder (eg: `GSR`), and start renaming the names.

Don't forget to rename these things:

* in `SSS__new_empty.m`: the signal's unit
* in `SSS__get_signame.m`: the signal's name. Replace-it by *SSS*

