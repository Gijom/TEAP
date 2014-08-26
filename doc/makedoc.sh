#!/bin/bash

for file in *.markdown; do
	file=`echo $file | cut -d. -f1`
	markdown $file.markdown > $file.html
done

#cat *.html > globaldoc.html

htmldoc --book --links --titlefile Title.html  --footer h./ P*.html > documentation.htmla
#htmldoc --book --links --title --cont --headfootsize 8.0 --linkcolor blue --linkstyle plain \
#        --format pdf14 globaldoc.html > documentation.pdf

rm *.html

mv documentation.htmla documentation.html
