#!/bin/bash

LAL_HEADERS="/usr/local/include"
LAL_LIBRARY="/usr/local/lib"

if [ -z $1 ]; then

PYTHON_HEADERS="/usr/include/python3.8"
PYTHON_LIBRARY="/usr/lib/x86_64-linux-gnu/"

./compile.sh \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$PYTHON_HEADERS" \
	--python-libs="$PYTHON_LIBRARY" \
	--python-major="3" \
	--python-minor="8" \
	--build=release

./compile.sh \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$PYTHON_HEADERS" \
	--python-libs="$PYTHON_LIBRARY" \
	--python-major="3" \
	--python-minor="8" \
	--build=debug

# for miniconda users only
elif [ "$1" == "miniconda" ]; then

miniconda_dir="/home/$USER/miniconda3"

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

anaconda_dir="/home/$USER/anaconda3"

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
