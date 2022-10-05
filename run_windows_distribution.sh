#!/bin/bash

LAL_HEADERS="C:/programming/msys64/home/Usuari/LAL-DISTRIBUTION/latest/lal-c++-libs/include"
LAL_LIBRARY="C:/programming/msys64/home/Usuari/LAL-DISTRIBUTION/latest/lal-c++-libs/bin"

if [ -z $1 ]; then

PYTHON_HEADERS="C:/programming/msys64/mingw64/include/python3.10"
PYTHON_LIBRARY=""

./compile.sh \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$PYTHON_HEADERS" \
	--python-libs="$PYTHON_LIBRARY" \
	--python-major="3" \
	--python-minor="10" \
	--build=release

./compile.sh \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
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
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$miniconda_dir/include/python3.9" \
	--python-libs="$miniconda_dir/lib" \
	--python-major="3" \
	--python-minor="9" \
	--build=release \
	--anaconda

./compile.sh \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$miniconda_dir/include/python3.9" \
	--python-libs="$miniconda_dir/lib" \
	--python-major="3" \
	--python-minor="9" \
	--build=debug \
	--anaconda

# for anaconda users only
elif [ "$1" == "anaconda" ]; then

anaconda_dir="C:/Users/Usuari/anaconda3"

./compile.sh \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$anaconda_dir/include/python3.9" \
	--python-libs="$anaconda_dir/lib" \
	--python-major="3" \
	--python-minor="9" \
	--build=release \
	--anaconda

./compile.sh \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$anaconda_dir/include/python3.9" \
	--python-libs="$anaconda_dir/lib" \
	--python-major="3" \
	--python-minor="9" \
	--build=debug \
	--anaconda

fi