#!/bin/bash

LAL_HEADERS="../linear-arrangement-library"
LAL_LIBRARY_RELEASE="../linear-arrangement-library/lal-release"
LAL_LIBRARY_DEBUG="../linear-arrangement-library/lal-debug"

if [ -z $1 ]; then

PYTHON_HEADERS="C:/programming/msys64/mingw64/include/python3.10"
PYTHON_LIBRARY=""

./compile.sh \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY_RELEASE" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$PYTHON_HEADERS" \
	--python-libs="$PYTHON_LIBRARY" \
	--python-major="3" \
	--python-minor="10" \
	--build=release

./compile.sh \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY_DEBUG" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$PYTHON_HEADERS" \
	--python-libs="$PYTHON_LIBRARY" \
	--python-major="3" \
	--python-minor="10" \
	--build=debug

# for miniconda users only
elif [ "$1" == "miniconda" ]; then

miniconda_dir="C:/Users/Usuari/miniconda3"

./compile.sh \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY_RELEASE" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$miniconda_dir/include" \
	--python-libs="$miniconda_dir" \
	--python-major="3" \
	--python-minor="9" \
	--build=release \
	--anaconda

./compile.sh \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY_DEBUG" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$miniconda_dir/include" \
	--python-libs="$miniconda_dir" \
	--python-major="3" \
	--python-minor="9" \
	--build=debug \
	--anaconda

# for anaconda users only
elif [ "$1" == "anaconda" ]; then

anaconda_dir="C:/Users/Usuari/anaconda3"

./compile.sh \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY_RELEASE" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$anaconda_dir/include" \
	--python-libs="$anaconda_dir" \
	--python-major="3" \
	--python-minor="8" \
	--build=release \
	--anaconda

./compile.sh \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY_DEBUG" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$anaconda_dir/include" \
	--python-libs="$anaconda_dir" \
	--python-major="3" \
	--python-minor="8" \
	--build=debug \
	--anaconda

fi
