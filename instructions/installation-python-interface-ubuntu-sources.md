# Installation of the interface for Python (Ubuntu)

LAL is interfaced to [Python 3](https://www.python.org/) via [SWIG](http://www.swig.org/). In order to compile the interface, you need to have `python3`, `SWIG` and `make` tools installed in your system. Optionally, you may install `bibtex` and `doxygen`.

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

## Configuring the _compile_ script

In order to compile the interface, you have to configure two build scripts (change just a few directories). For this, it is required that you know

- the location of the python binaries and header development files,
- the location where LAL has been installed in the system.

With this information, you will have to edit the [sample script file](https://github.com/LAL-project/python-interface/blob/main/sample_script.sh). Fill in the values of the variables named in upper case. Those variables with '(?)' to their right can be left empty.
	
	LAL_HEADERS=                        # directory of the header files of LAL
	LAL_LIBRARY=                        # directory of the binary files of LAL (.so)
	LAL_PYTHON_WRAPPER_DESTINATION=     # directory where to install LAL's python wrapper
	GMP_HEADERS=                        # (?) directory of the header files of GMP
	GMP_LIBRARY=                        # (?) directory of the binary files of GMP (.so)
	PYTHON_HEADERS=                     # directory of the header (development) files of python

Check the other [two](https://github.com/LAL-project/python-interface/blob/main/run_distribution_ubuntu.sh) [script](https://github.com/LAL-project/python-interface/blob/main/run_install_ubuntu.sh) files to see examples of contents.

## Compiling and installing the interface

We offer two different builds for the python interface `debug` and `release`. Each build is linked against the corresponding compilation of the library.

In order to have a more enjoyable, less frustrating experience using LAL, users should make the documentation for the Python wrapper files. This step, however, is completely optional and can be skipped. If skipped, run the command.

	$ touch modules/documentation.i

To generate the documentation for the Python wrapper files, run the following commands.

	$ cd /path/to/linear-arrangement-library
	$ ./make_docs.sh

Now, we can actually compile and install in one step the Python interface.

	$ ./sample_script.sh

