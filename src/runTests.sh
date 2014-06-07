#!/bin/bash

#First, syntax check
./tests/checkMatlabCompatibility.sh

#and pedantic style checks
./tests/checkStyle.sh


#then, unit testing
result=$(octave -q tests/unitTesting.m | grep 'test failed')

if [ -n "$result" ]; then
	echo 'Some tests failed ! Run runTests.m to see them';
fi
