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
#Description of how the functions work

