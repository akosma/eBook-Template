DIR = _build
INPUT = master
OUTPUT = book
DIAGRAM = --require=asciidoctor-diagram
OUTPUT_FOLDER = --destination-dir=${DIR}
HTML = --backend=html5 --a data-uri -a max-width=55em --out-file=${OUTPUT}.html
PDF =  --backend=pdf --require=asciidoctor-pdf -a pdf-stylesdir=resources/pdfstyles -a pdf-style=default --out-file=${OUTPUT}.pdf
EPUB_OPTIONS = --backend=epub3 --require=asciidoctor-epub3 -a epub3-stylesdir=resources/epubstyles
EPUB = ${EPUB_OPTIONS} --out-file=${OUTPUT}.epub
KINDLE = ${EPUB_OPTIONS} -a ebook-format=kf8 --out-file=${OUTPUT}.mobi

# Public targets

all: clean create_html create_pdf create_epub create_kindle bugfix

html: clean create_html

pdf: clean create_pdf

epub: clean create_epub bugfix

kindle: clean create_kindle bugfix

clean:
	if [ -d ".asciidoctor" ]; \
		then rm -r .asciidoctor; \
	fi; \
	if [ -d "${DIR}" ]; \
		then rm -r ${DIR}; \
	fi; \

# Private targets

create_html:
	asciidoctor ${DIAGRAM} ${OUTPUT_FOLDER} ${HTML} ${INPUT}.asc; \

create_pdf:
	asciidoctor ${DIAGRAM} ${OUTPUT_FOLDER} ${PDF} ${INPUT}.asc; \

create_epub:
	asciidoctor ${DIAGRAM} ${OUTPUT_FOLDER} ${EPUB} ${INPUT}.asc; \

create_kindle:
	asciidoctor ${DIAGRAM} ${OUTPUT_FOLDER} ${KINDLE} ${INPUT}.asc; \

# Required because of a bug in the epub3 generation,
# and to delete the intermediate file used in the
# generation of the Kindle file.
bugfix:
	if [ -d "chapters/images" ]; \
		then rm -r chapters/images; \
	fi; \
	if [ -e "${DIR}/${OUTPUT}-kf8.epub" ]; \
		then rm ${DIR}/${OUTPUT}-kf8.epub; \
	fi; \

