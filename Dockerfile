# docker build -t "akosma:ebook-template" .
# docker run -v ${PWD}:/workdir akosma:ebook-template
FROM ubuntu:18.04
MAINTAINER Adrian Kosmaczewski "akosma@me.com"

# Update packages
RUN apt-get update
RUN apt-get upgrade -y

# Install basics
RUN apt-get install -y build-essential

# Install Ruby and Python
RUN apt-get install -y ruby ruby-dev
RUN apt-get install -y python

# Install specifics
RUN apt-get install -y ghostscript
RUN apt-get install -y plantuml cmake bison flex
RUN apt-get install -y libxml2-dev libcairo2-dev libpango1.0-dev libgdk-pixbuf2.0-dev libffi-dev
RUN apt-get install -y fonts-lyx intltool

# Update Rubygems
RUN gem update --system
RUN gem update

# Install Ruby gems
RUN gem install rake
RUN gem install pygments.rb kindlegen asciimath asciidoctor epubcheck
RUN gem install asciidoctor-pdf asciidoctor-epub3 --pre
RUN MATHEMATICAL_SKIP_STRDUP=1 gem install mathematical
RUN gem install asciidoctor-mathematical asciidoctor-diagram

WORKDIR /workdir

# Done
ENTRYPOINT ["make"]

