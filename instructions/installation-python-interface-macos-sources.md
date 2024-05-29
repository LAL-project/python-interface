# Installation of the interface for Python (Mac OS)

**NOTE** *The instructions below will install LAL for anaconda. Therefore, it is assumed that you have [anaconda](https://www.anaconda.com/) installed in your computer.*

**NOTE** *These instructions were written a few years ago for a version of macOS (maybe 10.13?) that may behave differently from newer versions (including yours) and some paths below may have to be different.*

LAL is interfaced to [Python 3](https://www.python.org/) via [SWIG](http://www.swig.org/). In order to compile the interface, you need to have `python3`, `SWIG` and `make` tools installed in your system. Optionally, you may install `bibtex` and `doxygen`.

## Installing the dependencies

Users need to install the following dependencies.

### ghostscript

### Bibtex

### [`doxygen`](https://www.doxygen.nl/index.html)

	$ brew install doxygen

### LAL

Install LAL either from binaries or sources (see the [main README file](https://github.com/LAL-project/linear-arrangement-library/blob/master/README.md)).

### Python3 

According to [python-guide.org](https://docs.python-guide.org/starting/install3/osx/) you just need to issue the command

	$ brew install python

### SWIG

Users can use `homebrew` to install SWIG

	$ brew install swig
	
Please, ensure that the version of SWIG is 4.0.2 or newer:

	SWIG Version 4.0.2
	
If not, users are recommended to either find a way to "force" homebrew to install the latest SWIG, or install it from sources.

For the latter, download the latest release's sources from [SWIG's official webpage](http://www.swig.org/). Then, uncompress the file in a directory, say `~/Desktop/swig`. Compile the sources following the instructions provided in the file named `INSTALL`; read it to see the complete set of options for configuration of SWIG's installation. The installation instructions are summarized here:

	$ ./configure
	$ make
	$ make check # optional, but recommended
	$ make install

## Download the source code of the python interface

Navigate to a directory of your choice and issue the command

	$ git clone https://github.com/LAL-project/python-interface.git

## Configuring the _Makefile_

In order to compile the interface, you have to configure one of the build files (change just a few variables' contents). For this, one has to know where LAL has been installed in the system. With this information, you have to modify some of the variables in the corresponding Makefiles.

### Location of LAL

First of all, modify the variables `LAL_INC_DIR` and `LAL_LIB_DIR` with the location of LAL's header files and LAL's binary files in [`Makefile.lalsource`](https://github.com/LAL-project/python-interface/blob/main/Makefile.lalsource). For example,

	# ----------------
	# MACOS USERS ONLY
	
	# where are LAL's include files
	LAL_INC_DIR = 
	# where are LAL's library files
	LAL_LIB_DIR = 

(Modify the variables under the header `MACOS USERS ONLY`). Users who **did** specify a special installation directory when installing LAL then they should put said directory in the variables above.

### Location of Python sources and libraries

Secondly, specify the version of Python against which the interface is linked in [`Makefile.pythonsource`](https://github.com/LAL-project/python-interface/blob/main/Makefile.pythonsource). Indicate where Python's header files are located at, and where to find the binaries. To do this, modify the variables `PYTHON_INC_DIR` and `PYTHON_LIB_DIR`. The default values are the following

	# Python 3 include dir
	PYTHON_INC_DIR	= /usr/include/python3.$(MINOR_VERSION_PYTHON)
	
	# Python3 library directory
	PYTHON_LIB_DIR	= /usr/lib/x86_64-linux-gnu/

Users who installed *anaconda* may want to change the values for:

    # Python 3 include dir
	PYTHON_INC_DIR	= ~/opt/anaconda3/include/python3.$(MINOR_VERSION_PYTHON)
	
	# Python3 library directory
	PYTHON_LIB_DIR	= ~/opt/anaconda3/lib/

### Destination of LAL's python wrapper

Also in [`Makefile.pythonsource`](https://github.com/LAL-project/python-interface/blob/main/Makefile.pythonsource), users can also choose the destination directory of LAL's python interface by modifing the variable `LAL_PY_DEST`. The default value is

	# Directory where LAL's interface will be installed to
	LAL_PY_DEST		= /usr/local/lib/python3.$(MINOR_VERSION_PYTHON)/dist-packages

Users who wish to install LAL into *anaconda*'s installation directory may want to change the default value for:

	# Directory where LAL's interface will be installed to
	LAL_PY_DEST		= ~/opt/anaconda3/lib/python3.$(MINOR_VERSION_PYTHON)/site-packages

### Compiler

Last but not least, users must specify which compiler is to be used in [`Makefile`](https://github.com/LAL-project/python-interface/blob/main/Makefile). One requirement is that the compiler used must have support for `C++17`'s standard.

	CXX			= /usr/local/Cellar/gcc/11.2.0/bin/g++-11
	
We have tested the compilation on `g++` (version 11.2.0). Users who are willing to change the compiler, must also change the flags correspondingly.

	FLAGS		= -std=c++17 -fPIC -fopenmp

and also,

	# for debug builds
	FLAGS		+= -g -O3 -DDEBUG -D_GLIBCXX_DEBUG
	LIBS		+= -L $(LAL_LIB_DIR) -llal

	# for release builds
	FLAGS		+= -O3 -UDEBUG -DNDEBUG
	LIBS		+= -L $(LAL_LIB_DIR) -llaloptimized

## Compiling and installing the interface

We offer two different builds for the python interface `debug` and `release`. Each build is linked against the corresponding compilation of the library.

In order to have a more enjoyable, less frustrating experience using LAL, users should make the documentation for the Python wrapper files. This step, however, is completely optional and can be skipped. If skipped, users have to generate an empty file:

	$ touch modules/documentation.i

In order to generate the documentation for the Python wrapper files, issue the following commands.

	$ cd /path/to/linear-arrangement-library
	$ ./make_docs.sh

Now, we can actually compile the Python interface.

### `release` compilation and installation

	$ cd python-interface
	$ ./compile.sh --build=release --environment=distribution
	$ ./compile.sh --build=release --environment=distribution --install

### `debug` compilation and installation

	$ cd python-interface
	$ ./compile.sh --build=debug --environment=distribution
	$ ./compile.sh --build=debug --environment=distribution --install
