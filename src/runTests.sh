#!/bin/bash

result=$(octave -q runTests.m | grep 'test failed')

if [ -n "$result" ]; then
	echo 'Some tests failed ! Run runTests.m to see them';
fi
