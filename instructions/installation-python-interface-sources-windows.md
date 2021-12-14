# Installation of the interface for Python (Windows)

This library has been interfaced to [Python 3](https://www.python.org/) using the software [SWIG](http://www.swig.org/) (version 4.0.1). In order to compile the interface, you need to have the `SWIG` tool installed in your system. As for the rest, you only need the `make` tool.

## Installing the dependencies

### ghostscript

### Bibtex

### doxygen

Download the binaries for Windows following [these instructions](https://www.doxygen.nl/download.html).

### Python 3

Go to Python's [webpage](https://www.python.org/) and download one of the `3.x` builds for Windows. We have tested the interface with Python 3.6, but any `3.x` should work. Python builds for Windows can be found [here](https://www.python.org/downloads/windows/). When installing Python, make sure to check the box that says `Add Python 3.x to PATH`.

### SWIG

Download and install `SWIG` from its webpage. Authors of `SWIG` already provide downloadable files with prebuilt executables for windows. Download these and install them in your system. It is key to include the path to the installation folder in the `PATH` environment variable. For example, you can install SWIG in

	C:/programming/swig

and then add the path you used to the `PATH` environment variable.

## Donwload the source code of the python interface

In order to do so, you need to first download the sources of the linear arrangement library. First, navigate to a directory of your choice. Then in that directory, issue the commands

	$ git clone https://github.com/LAL-project/linear-arrangement-library.git
	$ git clone https://github.com/LAL-project/python-interface.git

## Configuring the _Makefile_

In order to compile the interface, you have to configure one of the build files (change just a few variables' contents). For this, it is required that you know

- the minor version of Python installed in your system,
- the compiler you want to use (we suggest GNU's `g++`),
- the location of the python binaries and header development files,
- the location of the GMP library in your system,
- the minor version of python installed (the interface has been tested on is `8` (i.e., we have been using `Python 3.8`), but should work on any version `3.x`)
- the location where LAL has been installed in the system.
	
With this information, you have to modify some of the variables in the Makefile files accordingly, as explained below.

First of all, modify the variables `LAL_INC_DIR` and `LAL_LIB_DIR` within [Makefile.lalsource](https://github.com/LAL-project/python-interface/blob/main/Makefile.lalsource) by overwriting their values with the location of LAL's header files and LAL's binary files. The default values are
	
	# ------------------
	# WINDOWS USERS ONLY
	
	# where are LAL's include files
	LAL_INC_DIR = C:/programming/c++/include
	# where are LAL's library files
	LAL_LIB_DIR = C:/programming/c++/bin

(Modify the variables under the header `WINDOWS USERS ONLY`).

Secondly, you have to specify the version of Python against which the interface is linked. Indicate where Python's header files are located at, and where to find the binaries. To do this, modify the variables `MINOR_VERSION_PYTHON` in [Makefile.pythonsource](https://github.com/LAL-project/python-interface/blob/main/Makefile.pythonsource). The default values are the following

	# Python's minor version
	MINOR_VERSION_PYTHON = 8

Replace the `8` above with the minor version of Python installed in your system.

Thirdly, you can also choose the destination directory of LAL's python interface. Modify the variable `LAL_PY_DEST` in the same [Makefile.pythonsource](https://github.com/LAL-project/python-interface/blob/main/Makefile.pythonsource). The default value is

	# Directory where LAL's interface will be installed to
	LAL_PY_DEST		= C:/programming/python_lib_3.$(MINOR_VERSION_PYTHON)

Last but not least, you must specify which compiler is to be used. One requirement is that the compiler used must have support for `C++17`'s standard. Modify the [Makefile.compiler](https://github.com/LAL-project/python-interface/blob/main/Makefile.compiler) accordingly

	CXX			= g++

If you change the compiler, change also the flags correspondingly.

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

	$ ./make_docs.sh

It is OK if you want to skip this step. However, if you do so, you need to create a special file.

	$ touch modules/documentation.i

Now you can actually compile the Python interface.

### RELEASE compilation and installation

	$ cd python-interface
	$ make BUILD=release ENVIR=dist -j4
	$ make BUILD=release ENVIR=dist install

### DEBUG compilation and installation

	$ cd python-interface
	$ make BUILD=debug ENVIR=dist -j4
	$ make BUILD=debug ENVIR=dist install

## Using the Python interface

It only remains one final step. This step depends on the minor version of Python you have. You need to help Python find LAL's `.dll` files

	liblal.dll liblaldebug.dll

Locate the destination directory of these files that you chose when installing LAL. Now add to the `PYTHONPATH` environment variable the directory to which the interface has been installed. This is the directory given to the variable `LAL_PY_DEST` in the Makefile (as explained above). This way, the python interpreter can find the `.py` files generated. This is sufficient for minor versions `6` and `7`. For minor version `8` copy the `.dll` files into your Python installation directory. For example,

	C:/Users/%USERNAME%/AppData/Python/Python3.8/

Note: this workaround does not look too good, but importing LAL does not work without this step.
