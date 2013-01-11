#!/usr/bin/env sh
# This script generates all the output files from the source Asciidoc
# files.

# Constants
DIR=_build
PDFOPTS="--format=pdf --conf-file=a2x.conf"
EPUBOPTS="--format=epub --fop --conf-file=a2x.conf --stylesheet=style.css"

# If the build directory exists, delete it
if [ -d "$DIR" ]; then
  rm -r $DIR
fi

# Create the build directory
mkdir $DIR

# Copy all files to the build directory
cp -R -L /opt/local/etc/asciidoc/images $DIR
cp images/* $DIR
cp chapters/* $DIR
cp conf/* $DIR
cp master.asciidoc $DIR

cd $DIR

# Generate HTML
asciidoc --out-file=booklet.html master.asciidoc

# Generate PDF
a2x $PDFOPTS master.asciidoc
mv master.pdf booklet.pdf

# Generate EPUB
a2x $EPUBOPTS master.asciidoc
mv master.epub booklet.epub

# Create Kindle version
/Applications/KindleGen_Mac_i386_v2_7/kindlegen booklet.epub

# Clean up, so that only the product files remain
rm *.png
rm *.conf
rm *.asciidoc
rm *.css
rm -r images/
rm *.sty

