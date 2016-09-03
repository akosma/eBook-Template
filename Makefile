DIR = _build
INPUT = master
OUTPUT = book
DIAGRAM = --require=asciidoctor-diagram
MATH = --require=asciidoctor-mathematical
REQUIRES = ${DIAGRAM} ${MATH}
OUTPUT_FOLDER = --destination-dir=${DIR}
HTML = --backend=html5 --a data-uri -a max-width=55em
PDF =  --backend=pdf --require=asciidoctor-pdf -a pdf-stylesdir=resources/pdfstyles -a pdf-style=default
EPUB = --backend=epub3 --require=asciidoctor-epub3 -a epub3-stylesdir=resources/epubstyles -a imagesdir=images
KINDLE = ${EPUB} -a ebook-format=kf8

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
	asciidoctor ${HTML} ${REQUIRES} ${OUTPUT_FOLDER} --out-file=${OUTPUT}.html ${INPUT}.asc; \

create_pdf:
	asciidoctor ${PDF} ${REQUIRES} ${OUTPUT_FOLDER} --out-file=${OUTPUT}.pdf ${INPUT}.asc; \

create_epub:
	asciidoctor ${EPUB} ${REQUIRES} ${OUTPUT_FOLDER} --out-file=${OUTPUT}.epub ${INPUT}.asc; \

create_kindle:
	asciidoctor ${KINDLE} ${REQUIRES} ${OUTPUT_FOLDER} --out-file=${OUTPUT}.mobi ${INPUT}.asc; \

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

