#  This makefile generates all the output files from the source Asciidoc files.

#  Constants
DIR = _build
BOOK = master
HTMLOPTS = -a max-width=55em
PDFOPTS = --format=pdf --conf-file=a2x.conf --fop
KINDLEGEN_PATH = /Applications/KindleGen_Mac_i386_v2_7
KINDLEGEN_OPTS = -c2
EPUBOPTS = --format=epub --conf-file=a2x.conf --stylesheet=style.css
ASCIIDOC_IMAGES = /usr/local/Cellar/asciidoc/8.6.8/etc/asciidoc/images
XML_CATALOG_FILES = /usr/local/Cellar/docbook-xsl/1.78.1/docbook-xsl/catalog.xml
DROPBOX = ~/Dropbox/La\ Cave\ Vivante/Manual


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
	fi; \

# Builds all the files and sends them 
# to Dropbox for sharing them with the team
deploy: all
	cd ${DIR}; \
	if [ -d ${DROPBOX} ]; \
		then rm -r ${DROPBOX}; \
	fi;\
	mkdir ${DROPBOX}; \
	cp ${BOOK}.* ${DROPBOX}; \


#  ---------------------------------
#  Private targets
#  If the build directory does not exist, create it
create_folder:
	if [ ! -d "${DIR}" ]; then \
		mkdir ${DIR}; \
		cp -R -L ${ASCIIDOC_IMAGES} ${DIR}; \
		cp images/* ${DIR}; \
		cp chapters/* ${DIR}; \
		cp conf/* ${DIR}; \
		cp ${BOOK}.asc ${DIR}; \
	fi; \


#  Generate HTML
create_html: create_folder
	cd ${DIR}; \
	asciidoc ${HTMLOPTS} --out-file=${BOOK}.html ${BOOK}.asc; \


#  Generate PDF
create_pdf: create_folder
	export XML_CATALOG_FILES=${XML_CATALOG_FILES}; \
	cd ${DIR}; \
	a2x ${PDFOPTS} ${BOOK}.asc; \


#  Generate EPUB
create_epub: create_folder
	export XML_CATALOG_FILES=${XML_CATALOG_FILES}; \
	cd ${DIR}; \
	a2x ${EPUBOPTS} ${BOOK}.asc; \

#  Create Kindle version (ignoring the error that it outputs)
create_kindle: create_epub 
	-if [ -d "${KINDLEGEN_PATH}" ]; then \
		${KINDLEGEN_PATH}/kindlegen ${KINDLEGEN_OPTS} ${DIR}/${BOOK}.epub; \
	fi; \

#  Clean up, so that only the product files remain
remove_files: create_folder
	cd ${DIR}; \
	rm -f *.png; \
	rm -f *.conf; \
	rm -f *.asc; \
	rm -f *.css; \
	rm -f *.jpeg; \
	rm -rf images/; \
	rm -f *.sty; \
	rm -f *.xml; \

