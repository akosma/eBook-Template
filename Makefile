# This script generates all the output files from the source Asciidoc
# files.

# Constants
DIR = _build
MASTER = master
OUTPUT = book
PDFOPTS = --format=pdf --conf-file=a2x.conf
KINDLEGEN = /Applications/KindleGen_Mac_i386_v2_7/kindlegen
EPUBOPTS = --format=epub --conf-file=a2x.conf --stylesheet=style.css


all: create_html create_pdf create_epub create_kindle remove_files

html: create_html remove_files

pdf: create_pdf remove_files

epub: create_epub remove_files

kindle: create_kindle remove_files


# If the build directory exists, delete it
clean:
	if [ -d "${DIR}" ]; then rm -r ${DIR}; fi

# If the build directory does not exist, create it
folder:
	if [ ! -d "${DIR}" ]; then mkdir ${DIR}; fi

copy_files: folder
	cp -R -L /opt/local/etc/asciidoc/images ${DIR}; \
	cp images/* ${DIR}; \
	cp chapters/* ${DIR}; \
	cp conf/* ${DIR}; \
	cp ${MASTER}.asc ${DIR}

create_html: copy_files
	cd ${DIR}; \
	asciidoc --out-file=${OUTPUT}.html ${MASTER}.asc

# Generate PDF
create_pdf: copy_files
	cd ${DIR}; \
	a2x ${PDFOPTS} ${MASTER}.asc; \
	mv ${MASTER}.pdf ${OUTPUT}.pdf

# Generate EPUB
create_epub: copy_files
	export XML_CATALOG_FILES=/opt/local/share/xsl/docbook-xsl/catalog.xml; \
	cd ${DIR}; \
	a2x ${EPUBOPTS} ${MASTER}.asc; \
	mv ${MASTER}.epub ${OUTPUT}.epub

# Create Kindle version (ignoring the error that it outputs)
create_kindle: create_epub 
	-${KINDLEGEN} ${DIR}/${OUTPUT}.epub

# Clean up, so that only the product files remain
remove_files: folder
	cd ${DIR}; \
	rm *.png; \
	rm *.conf; \
	rm *.asc; \
	rm *.css; \
	rm -r images/; \
	rm *.sty; \
	rm *.xml

