#!/bin/bash

#Extracts a particular signal from an 'ASCII generated' data from edfbrowser

dataFile=Participant*_data.txt
signal=41 #GSR
signal=$(($signal + 1)) #time

cat $dataFile | cut -d, -f $signal > outFile_$dataFile
