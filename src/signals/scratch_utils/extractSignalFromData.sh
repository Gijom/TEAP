#!/bin/bash

#Extracts a particular signal from an 'ASCII generated' data from edfbrowser

cat Participant*_signals.txt  | cut -f1 -d' ' | tail -n +2


echo -n "Which signal do you want > "
read signal

signVal=$(cat Participant*_signals.txt  | cut -f1 -d' ' | tail -n +2 | grep $signal | cut -d, -f2)



dataFile=Participant*_data.txt
signal=$(($signal + 1)) #time

cat $dataFile | cut -d, -f $signal > outFile_signal_$signVal
