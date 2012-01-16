Template for Writing an eBook
=============================

This project contains a template used to write eBooks using
[AsciiDoc][1], Git, MacVim and other tools on Mac OS X.

The aim of the project is to provide a boilerplate used to generate
eBooks in several formats on one operation:

- Self-contained HTML
- ePub
- PDF
- Kindle

How it Works
------------

The `master.asciidoc` file at the root of this project provides the
guiding structure of the book. Chapters can be shuffled around,
independently of their contents or internal structure.

Individual chapters are stored in the `chapters` folder, one file per
chapter.

Images are stored as PNG files in the `images` folder.

The `build.sh` script creates a temporary `_build` folder, copies all
the different elements in it (the master file, the chapters and the
images) and commands the execution of the whole toolchain in order to
get the final result.

Software Requirements
---------------------

Follow these instructions to install the required libraries in Mac OS X:

1. Install [Homebrew][2] if not already installed.
    - If already installed, remember to run `brew update`.
2. Download and install `asciidoc` using Homebrew:
    - `brew install asciidoc`
3. Install source-highlight with Homebrew:
    - `brew install source-highlight`
4. Download and install the latest MacTeX package from
    `http://www.tug.org/mactex/`
5. Install the `dblatex` package manually:
    - `brew install https://raw.github.com/bartschuller/homebrew/master/Library/Formula/dblatex.rb`
6. Download the [kindlegen][3] tool and install it in the following
   path:
    - `/Applications/KindleGen_Mac_i386_v2/kindlegen`

How to build the book 
---------------------

1. Make sure AsciiDoc and dblatex are properly installed.
2. Execute the booklet/build.sh script. This will create the PDF, ePub
   and HTML versions of the book.
3. The script also generates the .mobi (Amazon Kindle) version if the
   [kindlegen][3] tool is installed.

After the build process completes, the compiled eBooks will be available
at the `_build` subfolder.

Troubleshooting
---------------

If the generation of the PDF fails during "makeindex" follow the
instructions in this page:
<http://hackage.haskell.org/trac/ghc/wiki/Building/MacOSX> and add the
following line: `openout_any = r` to the file
`/usr/local/texlive/2011/texmf.cnf`

If the EPUB generation causes problems, check this page:
<http://francisshanahan.com/index.php/2011/fixing-epub-problem-docbook-xsl-asciidoc-a2x/>

Known Problems
--------------

dblatex has to be installed using a custom Homebrew formula, because the
default installation does not include it at the time of this writing.
This might change in the future.

### Why not generating the HTML using a2x?

Using a2x for the HTML creation has the following drawbacks:

- It takes longer;
- It does not embed the images in the HTML;
- It does not do syntax highlighting.

However, it creates an index when required.

[1]:http://www.methods.co.nz/asciidoc/
[2]:http://mxcl.github.com/homebrew/
[3]:http://www.amazon.com/gp/feature.html?ie=UTF8&docId=1000234621

