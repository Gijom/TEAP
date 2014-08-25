#!/bin/bash

for file in *.markdown; do
	file=`echo $file | cut -d. -f1`
	markdown $file.markdown > $file.html
done

cat *.html > globaldoc.html

htmldoc --cont --headfootsize 8.0 --linkcolor blue --linkstyle plain \
        --format pdf14 globaldoc.html > documentation.pdf

rm *.html
