#  This makefile generates all the output files from the source Asciidoc files.

#  Constants
DIR = _build
MASTER = master
OUTPUT = book
PDFOPTS = --format=pdf --conf-file=a2x.conf
KINDLEGEN = /Applications/KindleGen_Mac_i386_v2_7/kindlegen
EPUBOPTS = --format=epub --conf-file=a2x.conf --stylesheet=style.css
ASCIIDOC_ETC = /usr/local/Cellar/asciidoc/8.6.8/etc/asciidoc


#  ---------------------------------
#  Public targets
all: clean create_html create_pdf create_epub create_kindle remove_files

html: clean create_html remove_files

pdf: clean create_pdf remove_files

epub: clean create_epub remove_files

kindle: clean create_kindle remove_files

clean:
	if [ -d "${DIR}" ]; \
		then rm -r ${DIR}; \
	fi

#  ---------------------------------
#  Private targets
#  If the build directory does not exist, create it
create_folder:
	if [ ! -d "${DIR}" ]; then \
		mkdir ${DIR}; \
		cp -R -L ${ASCIIDOC_ETC}/images ${DIR}; \
		cp images/* ${DIR}; \
		cp chapters/* ${DIR}; \
		cp conf/* ${DIR}; \
		cp ${MASTER}.asc ${DIR}; \
	fi

#  Generate HTML
create_html: create_folder
	cd ${DIR}; \
	asciidoc --out-file=${OUTPUT}.html ${MASTER}.asc

#  Generate PDF
create_pdf: create_folder
	export XML_CATALOG_FILES=${ASCIIDOC_ETC}/dblatex; \
	cd ${DIR}; \
	a2x ${PDFOPTS} ${MASTER}.asc; \
	mv ${MASTER}.pdf ${OUTPUT}.pdf

#  Generate EPUB
create_epub: create_folder
	export XML_CATALOG_FILES=${ASCIIDOC_ETC}/dblatex; \
	cd ${DIR}; \
	a2x ${EPUBOPTS} ${MASTER}.asc; \
	mv ${MASTER}.epub ${OUTPUT}.epub

#  Create Kindle version (ignoring the error that it outputs)
create_kindle: create_epub 
	-${KINDLEGEN} ${DIR}/${OUTPUT}.epub

#  Clean up, so that only the product files remain
remove_files: create_folder
	cd ${DIR}; \
	rm -f *.png; \
	rm -f *.conf; \
	rm -f *.asc; \
	rm -f *.css; \
	rm -rf images/; \
	rm -f *.sty; \
	rm -f *.xml

