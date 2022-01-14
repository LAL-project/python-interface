# Installation of the interface for Python (Windows)

**NOTE** *We provide binaries for Windows that can be installed with an installer (those Next, Next clicky things). We recommend you install LAL using the installer, if possible.*

We first describe the basic setup of the system for the compilation of the python interface.

## Necessary tools and basic setup of the system

We recommend installing the [`MSYS2`](https://www.msys2.org/) subsystem for simplicity. This can be done following the 7 steps in their webpage. These consist of downloading and executing the installer and executing some very well-explained commands. With a fast internet connection it should take no more than 15 minutes. If you already did it when install [LAL from sources](https://github.com/LAL-project/linear-arrangement-library/blob/master/instructions/installation-library-sources-windows.md), you may skip this step.

## Installing the dependencies

The dependencies should be installed using the `MSYS2 MSYS` program. In Windows' Start menu, launch `MSYS2 MSYS`, and type the following commands. The dependencies that are not installed by the default are the following.

### git

	$ pacman -S git

### epstopdf, ghostscript

The following command will install `epstopdf` and `ghostscript` and other software on which these two depend.

	$ pacman -S mingw-w64-x86_64-texlive-font-utils

### Bibtex

	$ pacman -S mingw-w64-x86_64-texlive-bibtex-extra

### [`doxygen`](https://www.doxygen.nl/index.html)

	$ pacman -S mingw-w64-x86_64-doxygen

## Donwload the source code of the python interface

In order to do so, you need to first download the sources of the linear arrangement library. First, navigate to a directory of your choice. Then in that directory, issue the commands

	$ git clone https://github.com/LAL-project/linear-arrangement-library.git
	$ git clone https://github.com/LAL-project/python-interface.git

We need the source code of LAL to generate the documentation.

## Configuring the _Makefile_

In order to compile the interface, you have to configure one of the build files (change just a few variables' contents). For this, it is required that you know

- the minor version of Python installed in your system,
- the compiler you want to use (we suggest GNU's `g++`),
- the location of the python binaries and header development files,
- the location of the GMP library in your system,
- the minor version of python installed (the interface has been tested on is `9` (i.e., we have been using `Python 3.9`), but should work on any version `3.x`)
- the location where LAL has been installed in the system.
	
With this information, you have to modify some of the variables in the Makefile files accordingly, as explained below.

First of all, modify the variables `LAL_INC_DIR` and `LAL_LIB_DIR` within [Makefile.lalsource](https://github.com/LAL-project/python-interface/blob/main/Makefile.lalsource) by overwriting their values with the location of LAL's header files and LAL's binary files. The default values are
	
	# ------------------
	# WINDOWS USERS ONLY
	
	# location of LAL's include files
	LAL_INC_DIR = 
	# location of LAL's library files
	LAL_LIB_DIR = 

(Modify the variables under the header `WINDOWS USERS ONLY`).

### Configuration not for Anaconda

Secondly, you have to specify the version of Python against which the interface is linked. Indicate where Python's header files are located at, and where to find the binaries. To do this, modify the variables `MINOR_VERSION_PYTHON` in [Makefile.pythonsource](https://github.com/LAL-project/python-interface/blob/main/Makefile.pythonsource). The default value is the following

	# Python's minor version
	MINOR_VERSION_PYTHON = 9

Replace the `9` above with the minor version of Python installed in your system.

Thirdly, you can also choose the destination directory of LAL's python interface. Modify the variable `LAL_PY_DEST` in the same [Makefile.pythonsource](https://github.com/LAL-project/python-interface/blob/main/Makefile.pythonsource). If you are configuring this interface to work with Anaconda, do not change the default value. If not, you may change it. The default value is

	else ifeq ($(ANACONDA),no)
		...
    
		# Directory where LAL's interface will be installed to
		LAL_PY_DEST = /mingw64/lib/python3.$(MINOR_VERSION_PYTHON)

## Configuration for Anaconda

Technically, there should be no need to do any further configuration.

## Compiling and installing the interface

There are two different builds for the python interface `debug` and `release`. Each build is linked against the corresponding compilation of the library.

First, you must make the documentation for the Python interface files. For this, issue the following commands.

	$ ./make_docs.sh

It is OK if you want to skip this step. However, if you do so, you need to create a special file.

	$ touch modules/documentation.i

Now you can actually compile the Python interface.

### Not for Anaconda

For a release compilation and installation of the python interface, issue the following commands

	$ ./compile.sh --build=release --environment=distribution
	$ ./compile.sh --build=release --environment=distribution --install

For a debug compilation and installation of the python interface, issue the following commands

	$ ./compile.sh --build=debug --environment=distribution
	$ ./compile.sh --build=debug --environment=distribution --install

### For Anaconda

Similarly as before (but not exactly!), compile the library in debug and/or release mode.

For a release compilation and installation of the python interface, issue the following commands

	$ ./compile.sh --build=release --environment=distribution --anaconda
	$ ./compile.sh --build=release --environment=distribution --anaconda --install

For a debug compilation and installation of the python interface, issue the following commands

	$ ./compile.sh --build=debug --environment=distribution --anaconda
	$ ./compile.sh --build=debug --environment=distribution --anaconda --install

It remains one final step. This step is about moving the `.dll` files to the appropriate directory within Anaconda, in particular within the directories

	(1) C:/Users/%Username/anaconda3/Lib/site-packages/lal
	(2) C:/Users/%Username/anaconda3/Lib/site-packages/laldebug

Now, copy the file

	C:/msys64/mingw64/bin/libstdc++-6.dll

- (release builds) to directory (1) the `liblal.dll` file generated during the [release compilation of the sources](https://github.com/LAL-project/linear-arrangement-library/blob/master/instructions/installation-library-sources-windows.md).

- (debug builds) to directory (2) the `liblaldebug.dll` file generated during the [debug compilation of the sources](https://github.com/LAL-project/linear-arrangement-library/blob/master/instructions/installation-library-sources-windows.md).
