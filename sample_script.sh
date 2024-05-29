#!/bin/bash

LAL_HEADERS=                    # directory of the header files of LAL
LAL_LIBRARY=                    # directory of the binary files of LAL (.so)
LAL_PYTHON_WRAPPER_DESTINATION= # directory where to install LAL's python wrapper
GMP_HEADERS=                    # (?) directory of the header files of GMP
GMP_LIBRARY=                    # (?) directory of the binary files of GMP (.so)
PYTHON_HEADERS=                 # directory of the header (development) files of python
PYTHON_LIBRARY=                 # directory of the shared object (development) files of python
PYTHON_MINOR=                   # python's minor version (the 'x' in 3.x)

./compile.sh \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="$GMP_HEADERS" \
	--gmp-libs="$GMP_LIBRARY" \
	--python-headers="$PYTHON_HEADERS" \
	--python-libs="$PYTHON_LIBRARY" \
	--build=release

./compile.sh \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="$GMP_HEADERS" \
	--gmp-libs="$GMP_LIBRARY" \
	--python-headers="$PYTHON_HEADERS" \
	--python-libs="$PYTHON_LIBRARY" \
	--build=debug

sudo \
./compile.sh \
	--lal-destination="$LAL_PYTHON_WRAPPER_DESTINATION" \
	--build=release \
	--install

sudo \
./compile.sh \
	--lal-destination="$LAL_PYTHON_WRAPPER_DESTINATION" \
	--build=debug \
	--install
