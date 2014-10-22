Template for Writing an eBook
=============================

This project contains a template used to write eBooks using
[AsciiDoc][1], Git, and any plain text editor in Mac OS X.

The aim of the project is to provide a boilerplate used to generate
eBooks in several formats on one operation:

- Self-contained HTML
- ePub
- PDF
- Kindle

Motivation
----------

Why using such a complex setup instead of just using a simpler tool like
Word or Pages?

- The primary motivation of this template is versioning. Being able to
  use plain text files as input for the book brings the possibility of
  versioning each change individually using Git, Subversion or any other
  similar tool. This also opens up the door to collaboration among team
  members when editing a document.
- The second motivation is to separate the presentation and the layout
  of the final book from its contents. Other output file types could be
  added in the future.
- This also brings the possibility of using any text editor in just
  about any operating system; files are just plain text files that can
  be edited with gEdit, Notepad, Emacs, Vim, TextEdit, or any other
  similar tool.
- Markup languages like Markdown or Asciidoc (used in this template) are
  simpler and more readable than LaTeX or other SGML-like languages,
  making the files readable and lean even when edited in a text editor
  without any syntax highlighting or formatting support.
- Finally, being able to streamline the creation of the three versions
  of the book in just one command-line operation allows the whole setup
  to be automatized.

How it Works
------------

The `master.asciidoc` file at the root of this project provides the
guiding structure of the book. Chapters can be shuffled around,
independently of their contents or internal structure.

Individual chapters are stored in the `chapters` folder, one file per
chapter.

Images are stored as PNG files in the `images` folder.

The Makefile creates a temporary `_build` folder, copies all the
different elements in it (the master file, the chapters and the images)
and commands the execution of the whole toolchain in order to get the
final result.

Software Requirements
---------------------

Follow these instructions to install the required libraries in Mac OS X:

1. Install [Homebrew][2] if not already installed.
    - If already installed, remember to run `brew update; brew upgrade`.
2. Download and install `asciidoc` using Homebrew:
    - `brew install asciidoc`
3. Install source-highlight with Homebrew (this will install Boost 
   as a dependency):
    - `brew install source-highlight`
4. Install the `dblatex` package with Homebrew:
    - `brew install dblatex`
5. If the above command does not work, follow the instructions here:
   `https://gist.github.com/dustinschultz/6554087`
6. Download the [kindlegen][3] tool and install it in the following
   path:
    - `/Applications/KindleGen_Mac_i386_v2_7/kindlegen`

How to build the book 
---------------------

1. Make sure AsciiDoc and dblatex are properly installed.
2. Execute the `make` command. This will create the PDF, ePub and HTML
   versions of the book.
3. `make pdf`, `make html`, `make epub` and `make kindle` each generate
   the specified version of the booklet.
4. `make clean` removes the `_build` folder.

The .mobi (Amazon Kindle) version requires the [kindlegen][3] tool.

After the build process completes, the compiled eBooks will be available
at the `_build` subfolder.

License
-------

See the LICENSE.md file.


[1]:http://www.methods.co.nz/asciidoc/
[2]:http://brew.sh
[3]:http://www.amazon.com/gp/feature.html?ie=UTF8&docId=1000234621

