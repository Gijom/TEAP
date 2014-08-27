#!/bin/bash
#You need: markdown(1), htmldoc(1) and wkhtmltopdf(1)

#Convert all markdown to html
for file in *.markdown; do
	file=`echo $file | cut -d. -f1`
	markdown $file.markdown > $file.html
done

#Convert to a book
htmldoc --book --links --titlefile Title.html  --footer h./ P*.html > documentation.htmla

rm *.html

mv documentation.htmla documentation.html

#Convert to pdf
wkhtmltopdf documentation.html documentation.pdf
