# Installation of the interface for Python (Mac OS)

**NOTE** *The instructions below will install LAL for anaconda. Therefore, it is assumed that you have [anaconda](https://www.anaconda.com/) installed in your computer.*

This library has been interfaced to [Python 3](https://www.python.org/) using the software [SWIG](http://www.swig.org/) (version 4.0.2). In order to compile the interface, you need to have `python3`, `SWIG` and `make` tools installed in your system. Optionally, you may install `bibtex` 

## Installing the dependencies

### Bibtex (optional, for the documentation)

The easiest way to install the latest LaTeX distribution is by issuing the command

	$ brew install --cask mactex

### Doxygen (optional, for the documentation)

[`doxygen`](https://www.doxygen.nl/index.html) can be installed by issuing the following command

	$ brew install doxygen

### LAL

Install LAL either from binaries or sources (see the [main README file](https://github.com/LAL-project/linear-arrangement-library/blob/master/README.md)).

### Python3 

According to [python-guide.org](https://docs.python-guide.org/starting/install3/osx/) you just need to issue the command

	$ brew install python

### SWIG

Download the latest swig sources from [SWIG's official webpage](http://www.swig.org/) and uncompress the file in a directory, say `~/Desktop/swig`. Compile the sources following the instructions provided in the file named `INSTALL`; read it to see the complete set of options for configuration of SWIG's installation.

The installation instructions are summarised here:

	$ ./configure
	$ make
	$ make check # optional, but recommended
	$ make install


## Configuring the _Makefile_

In order to compile the interface, you have to configure one of the build files (change just a few variables' contents). For this, it is required that you know the minor version of Python installed in your system. As stated above, the major version is required to be `3`. The minor version the interface has been tested on is `8` (i.e., we have been using `Python 3.8`), but should work on any version `3.x`. Moreover, one has to know where LAL has been installed in the system. With this information, you have to modify some of the variables in the [`linear-arrangement-library/python-interface/Makefile`](https://github.com/LAL-project/linear-arrangement-library/blob/master/python-interface/Makefile) accordingly.

First of all, modify the variables `LAL_INC_DIR` and `LAL_LIB_DIR` with the location of LAL's header files and LAL's binary files. For example,

	# ----------------
	# MACOS USERS ONLY
	
	# where are LAL's include files
	LAL_INC_DIR = /usr/local/include
	# where are LAL's library files
	LAL_LIB_DIR = /usr/local/lib

(Modify the variables under the header `MACOS USERS ONLY`).

Secondly, specify the version of Python against which the interface is linked. Indicate where Python's header files are located at, and where to find the binaries. To do this, modify the variables `MINOR_VERSION_PYTHON`, `PYTHON_INC_DIR` and `PYTHON_LIB_DIR`. The default values are the following

	# ----------------
	# MACOS USERS ONLY
	
	# Python's minor version
	MINOR_VERSION_PYTHON = 8
	
	# Python 3 include dir
	PYTHON_INC_DIR	= /usr/include/python3.$(MINOR_VERSION_PYTHON)
	
	# Python3 library directory
	PYTHON_LIB_DIR	= /usr/lib/x86_64-linux-gnu/

Users who installed *anaconda* may want to change the values for:

	# Python 3 include dir
	PYTHON_INC_DIR	= ~/opt/anaconda3/include/python3.$(MINOR_VERSION_PYTHON)
	
	# Python3 library directory
	PYTHON_LIB_DIR	= ~/opt/anaconda3/lib/

Thirdly, you can also choose the destination directory of LAL's python interface. Modify the variable `LAL_PY_DEST`. The default value is

	# Directory where LAL's interface will be installed to
	LAL_PY_DEST		= /usr/local/lib/python3.$(MINOR_VERSION_PYTHON)/dist-packages

Users who want to install LAL into *anaconda*'s installation directory may want to change the default value for:

	# Directory where LAL's interface will be installed to
	LAL_PY_DEST		= ~/opt/anaconda3/lib/python3.$(MINOR_VERSION_PYTHON)/site-packages

Last but not least, you must specify which compiler is to be used. One requirement is that the compiler used must have support for `C++17`'s standard.

	# ----------------
	# MACOS USERS ONLY
	
	CXX			= /usr/local/Cellar/gcc/11.2.0/bin/g++-11
	
We have tested the compilation on `g++` (version 11.2.0). If you change the compiler, change also the flags correspondingly.

	FLAGS		= -std=c++17 -fPIC -fopenmp

and also,

	# for debug builds
	FLAGS		+= -g -O3 -DDEBUG -D_GLIBCXX_DEBUG
	LIBS		+= -L $(LAL_LIB_DIR) -llaldebug

	# for release builds
	FLAGS		+= -O3 -UDEBUG -DNDEBUG
	LIBS		+= -L $(LAL_LIB_DIR) -llal

## Compiling and installing the interface

We offer two different builds for the python interface `debug` and `release`. Each build is linked against the corresponding compilation of the library.

First, you must make the documentation for the Python interface files. For this, issue the following commands.

	$ cd /path/to/linear-arrangement-library
	$ ./make_docs.sh python # optional

Now you can actually compile the Python interface.

### `release` compilation and installation

	$ cd python-interface
	$ make BUILD=release ENVIR=dist -j4
	$ make BUILD=release ENVIR=dist install

### `debug` compilation and installation

	$ cd python-interface
	$ make BUILD=debug ENVIR=dist -j4
	$ make BUILD=debug ENVIR=dist install
