#!/bin/bash

#I code in octave, and as octave syntax is way better, I may find myself
#Doing things like if( a != 42), whereas matlab needs (poor baby) ~=.

#So these are just some trivial checks to make sure that I didn't leaked some
#'typos'


#Check for comparisons
git grep '\!\=' #!=
git grep '(\!'  #(!   if(!foo…

#Stupid matlab doesn't support things like i++, i+=, etc.
git grep '++'   #++
git grep '+\='  #+=
git grep -e '\-\-' --and --not -e '<\!\-\-' # --; we dont want xml comments
git grep '\-\=' #-=

