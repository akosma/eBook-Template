#!/usr/bin/env sh
# This script generates all the output files from the source Asciidoc
# files.

# Constants
DIR=_build
TITLE="eBook-Template"

# Uncomment or comment to enable or disable
PDF="yes"
EPUB="yes"
KINDLE="yes"
# HTMLHELP="yes"

ASCIIDOC_IMAGES_DIR="/usr/local/etc/asciidoc/images"


# If the build directory exists, delete it
if [ -d "$DIR" ]; then
  rm -r $DIR
fi

# Create the build directory
mkdir $DIR

# Copy all files to the build directory
if [ -d "$ASCIIDOC_IMAGES_DIR" ]
then
    cp -R -L $ASCIIDOC_IMAGES_DIR $DIR
else
    echo "WARNING: $ASCIIDOC_IMAGES_DIR does not exists; errors may ensue."
fi
if [ ! -d $DIR/images ]
then
    mkdir $DIR/images
fi

search_for="master.asciidoc chapters/* conf/*"
clean_files=""
for p in $search_for; do
    cp $p $DIR
    clean_files="$clean_files $(basename $p)"
done
for p in $(ls images); do
    cp $p $DIR/images
done

cd $DIR

# Generate HTML
asciidoc --out-file=$TITLE.html master.asciidoc

# Generate HTML Help
if [ "$HTMLHELP" = "yes" ]
then
    mkdir htmlhelp
    a2x --format=htmlhelp --conf-file=a2x.conf master.asciidoc
    mv master.hhc htmlhelp/$TITLE.hhc
    mv master.hhk htmlhelp/$TITLE.hhk
    mv master.hhp htmlhelp/$TITLE.hhp
    mv master.htmlhelp htmlhelp/$TITLE.htmlhelp
fi

# Generate PDF
if [ "$PDF" = "yes" ]
then
    a2x --format=pdf --conf-file=a2x.conf master.asciidoc
    mv master.pdf $TITLE.pdf
fi

# Generate EPUB
if [ "$EPUB" = "yes" -o "$KINDLE" = "yes" ]
then
    a2x --format=epub --conf-file=a2x.conf --stylesheet=style.css master.asciidoc
    mv master.epub $TITLE.epub
fi

# Create Kindle version
if [ "$KINDLE" = "yes" ]
then
    /Applications/KindleGen_Mac_i386_v2/kindlegen $TITLE.epub
fi

# Clean up, so that only the product files remain
# rm *.png
# rm *.conf
# rm *.asciidoc
# rm *.css
# rm *.sty
for p in $clean_files; do
    rm $p
done
rm -r images
