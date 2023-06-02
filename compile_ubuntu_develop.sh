#!/bin/bash

LAL_HEADERS="../linear-arrangement-library"
LAL_LIBRARY_RELEASE="../linear-arrangement-library/lal-release"
LAL_LIBRARY_DEBUG="../linear-arrangement-library/lal-debug"

if [ -z $1 ]; then

PYTHON_HEADERS="/usr/include/python3.10"
PYTHON_LIBRARY="/usr/lib/x86_64-linux-gnu/"

./compile.sh \
	--environment=development \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY_RELEASE" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$PYTHON_HEADERS" \
	--build=release

./compile.sh \
	--environment=development \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY_DEBUG" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$PYTHON_HEADERS" \
	--build=debug

# for miniconda users only
elif [ "$1" == "miniconda" ]; then

miniconda_dir="/home/$USER/miniconda3"

./compile.sh \
	--environment=development \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY_RELEASE" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$miniconda_dir/include/python3.9" \
	--build=release \
	--anaconda

./compile.sh \
	--environment=development \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY_DEBUG" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$miniconda_dir/include/python3.9" \
	--build=debug \
	--anaconda

# for anaconda users only
elif [ "$1" == "anaconda" ]; then

anaconda_dir="/home/$USER/anaconda3"

./compile.sh \
	--environment=development \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY_RELEASE" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$anaconda_dir/include/python3.9" \
	--build=release \
	--anaconda

./compile.sh \
	--environment=development \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY_DEBUG" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$anaconda_dir/include/python3.9" \
	--build=debug \
	--anaconda

fi
