# Installation of the interface for Python (Windows)

**NOTE** *We provide binaries for Windows that can be installed with an installer (those Next, Next clicky things). We recommend you install LAL using the installer, if possible.*

We first describe the basic setup of the system for the compilation of the python interface.

## Necessary tools and basic setup of the system

We recommend installing the [`MSYS2`](https://www.msys2.org/) subsystem for simplicity. This can be done following the 7 steps in their webpage. These consist of downloading and executing the installer and executing some very well-explained commands. With a fast internet connection it should take no more than 15 minutes. If you already did it when install [LAL from sources](https://github.com/LAL-project/linear-arrangement-library/tree/24.10/instructions/installation-library-sources-windows.md), you may skip this step.

## Installing the dependencies

The dependencies should be installed using the `MSYS2 MSYS` program. In Windows' Start menu, launch `MSYS2 MSYS`, and type the following commands. The dependencies that are not installed by the default are the following.

### git

	$ pacman -S git

### epstopdf, ghostscript

The following command will install `epstopdf` and `ghostscript` and other software on which these two depend.

	$ pacman -S mingw-w64-x86_64-texlive-font-utils

### Bibtex

	$ pacman -S mingw-w64-x86_64-texlive-bibtex-extra

### [doxygen](https://www.doxygen.nl/index.html)

	$ pacman -S mingw-w64-x86_64-doxygen

### [SWIG](https://www.swig.org/)

	$ pacman -S mingw-w64-x86_64-swig

### LAL

Install LAL either from binaries or sources (see the [main README file](https://github.com/LAL-project/linear-arrangement-library/tree/24.10/README.md)) of that project.

## Download the source code of the python interface

Navigate to a directory of your choice and issue the command

	$ git clone https://github.com/LAL-project/python-interface.git

## Configuring the _compile_ script

In order to compile the interface, you have to configure two build scripts (change just a few directories). For this, it is required that you know

- the location of the python binaries and header development files,
- the location where LAL has been installed in the system.

With this information, you will have to edit the [sample script file](https://github.com/LAL-project/python-interface/tree/24.10/sample_script.sh). Fill in the values of the variables named in upper case. Those variables with '(?)' to their right can be left empty.
	
	LAL_HEADERS=                      # directory of the header files of LAL
	LAL_LIBRARY=                      # directory of the binary files of LAL (.so)
	LAL_PYTHON_WRAPPER_DESTINATION=   # directory where to install LAL's python wrapper
	GMP_HEADERS=                      # (?) directory of the header files of GMP
	GMP_LIBRARY=                      # (?) directory of the binary files of GMP (.so)
	PYTHON_HEADERS=                   # directory of the header (development) files of python
	PYTHON_LIBRARY=                   # directory of the shared object (development) files of python

Check the other [two](https://github.com/LAL-project/python-interface/tree/24.10/windows_compile_distribution.sh) [script](https://github.com/LAL-project/python-interface/tree/24.10/windows_install.sh) files to see examples of contents.

## Compiling and installing the interface

We offer two different builds for the python interface `debug` and `release`. Each build is linked against the corresponding compilation of the library.

In order to have a more enjoyable, less frustrating experience using LAL, users should make the documentation for the Python wrapper files. This step, however, is completely optional and can be skipped. If skipped, run the command.

	$ touch modules/documentation.i

To generate the documentation for the Python wrapper files, run the following commands.

	$ cd /path/to/linear-arrangement-library
	$ ./make_docs.sh

Now, we can actually compile and install in one step the Python interface.

	$ ./sample_script.sh

### Last steps of the installation for `conda`

**Note** These steps assume that the library was compiled and linked against the python development files distributed with conda.

Move the `.dll` files to the appropriate directory within Anaconda, in particular within the directories

	(1) C:/Users/$USER/anaconda3/Lib/site-packages/lal
	(2) C:/Users/$USER/anaconda3/Lib/site-packages/laloptimized

(replace `anaconda3` with `miniconda3` where appropriate).

For this, copy the necessary dll files for LAL. These can be checked with the command

	$ ldd liblal.dll
	$ ldd liblaloptimized.dll

In our most recent build, these were:

	C:/msys64/mingw64/bin/libgcc_s_seh-1.dll
	C:/msys64/mingw64/bin/libgmp-10.dll
	C:/msys64/mingw64/bin/libgomp-1.dll
	C:/msys64/mingw64/bin/libstdc++-6.dll
	C:/msys64/mingw64/bin/libwinpthread-1.dll

Copy the dll files to both directories `lal` and `laloptimized` within conda installation. Also, if the files generated during the [debug and release compilation of LAL's sources](https://github.com/LAL-project/linear-arrangement-library/tree/24.10/instructions/installation-library-sources-windows.md) are not accessible in the path, then move the files

- `liblal.dll` into `lal` (within conda), and
- `liblaloptimized.dll` into `laloptimized` (within conda).
