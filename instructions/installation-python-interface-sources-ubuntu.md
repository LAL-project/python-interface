# Installation of the interface for Python (Ubuntu)

This library has been interfaced to [Python 3](https://www.python.org/) using the software [SWIG](http://www.swig.org/) (version 4.0.2). In order to compile the interface, you need to have `python3`, `SWIG` and `make` tools installed in your system. Optionally, you may install `bibtex` and `doxygen`.

All the instructions below require the use of a command-line terminal. Head over to [this basic tutorial](https://ubuntu.com/tutorials/command-line-for-beginners#1-overview) if you think you would like to feel more comfortable in using the terminal.

## Installing the dependencies

### epstopdf

	$ sudo apt install texlive-font-utils

### ghostscript

	$ sudo apt install ghostscript

### Bibtex

	$ sudo apt install texlive-bibtex-extra

### [`doxygen`](https://www.doxygen.nl/index.html)

	$ sudo apt install doxygen

### LAL

Install LAL either from binaries or sources (see the [main README file](https://github.com/LAL-project/linear-arrangement-library/blob/master/README.md)) of that project.

### Python3 

	$ sudo apt install python3.8 python3-dev python3.8-dev

### SWIG

Download the latest swig sources from [SWIG's official webpage](http://www.swig.org/) and uncompress the file in a directory, say `~/Desktop/swig`. Compile the sources following the instructions provided in the file named `INSTALL`; read it to see the complete set of options for configuration of SWIG's installation.

The installation instructions are summarized here:

	$ ./configure
	$ make
	$ make check # optional, but recommended
	$ sudo make install

## Download the source code of the python interface

Navigate to a directory of your choice and issue the command

	$ git clone https://github.com/LAL-project/python-interface.git

## Configuring the _Makefile_

In order to compile the interface, you have to configure one of the build files (change just a few variables' contents). For this, it is required that you know

- the minor version of Python installed in your system,
- the compiler you want to use (we suggest GNU's `g++`),
- the location of the python binaries and header development files,
- the minor version of python installed (the interface has been tested on is `8` (i.e., we have been using `Python 3.8`), but should work on any version `3.x`)
- the location where LAL has been installed in the system.

With this information, you have to modify some of the variables in the Makefile files accordingly, as explained below.

First of all, modify the variables `LAL_INC_DIR` and `LAL_LIB_DIR` within [Makefile.lalsource](https://github.com/LAL-project/python-interface/blob/main/Makefile.lalsource) by overwriting their values with the location of LAL's header files and LAL's binary files. The default values are

	# ----------------
	# LINUX USERS ONLY
	
	# location of LAL's include files
	LAL_INC_DIR = 
	# location of LAL's library files
	LAL_LIB_DIR = 

(Modify the variables under the header `LINUX USERS ONLY`).

Secondly, you have to specify the version of Python against which the interface is linked. Indicate where Python's header files are located at, and where to find the binaries. To do this, modify the variables `MINOR_VERSION_PYTHON`, `PYTHON_INC_DIR` and `PYTHON_LIB_DIR` in [Makefile.pythonsource](https://github.com/LAL-project/python-interface/blob/main/Makefile.pythonsource). The default value is the following

	# Python's minor version
	MINOR_VERSION_PYTHON = 8
	
Thirdly, you can also choose the destination directory of LAL's python interface. Modify the variable `LAL_PY_DEST` in the same [Makefile.pythonsource](https://github.com/LAL-project/python-interface/blob/main/Makefile.pythonsource). The default value is

	# Directory where LAL's interface will be installed to
	LAL_PY_DEST = /usr/local/lib/python3.$(MINOR_VERSION_PYTHON)
	
## Compiling and installing the interface

We offer two different builds for the python interface `debug` and `release`. Each build is linked against the corresponding compilation of the library.

In order to have a more enjoyable, less frustrating experience using LAL, users should make the documentation for the Python wrapper files. This step, however, is completely optional and can be skipped. If skipped, users have to generate an empty file:

	$ touch modules/documentation.i

In order to generate the documentation for the Python wrapper files, issue the following commands.

	$ cd /path/to/linear-arrangement-library
	$ ./make_docs.sh

Now, we can actually compile the Python interface.

### Release compilation and installation

	$ ./compile.sh --build=release --environment=distribution
	$ ./compile.sh --build=release --environment=distribution --install

### Debug compilation and installation

	$ ./compile.sh --build=debug --environment=distribution
	$ ./compile.sh --build=debug --environment=distribution --install
