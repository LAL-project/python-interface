#!/bin/bash

LAL_HEADERS="../linear-arrangement-library"
LAL_LIBRARY_RELEASE="../linear-arrangement-library/lal-release"
LAL_LIBRARY_DEBUG="../linear-arrangement-library/lal-debug"

if [ -z $1 ]; then

PYTHON_HEADERS="/usr/include/python3.12"

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

# for anaconda users only
elif [ "$1" == "anaconda" ]; then

anaconda_dir="/home/$USER/anaconda3"

./compile.sh \
	--environment=development \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY_RELEASE" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$anaconda_dir/include/python3.12" \
	--build=release

./compile.sh \
	--environment=development \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY_DEBUG" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$anaconda_dir/include/python3.12" \
	--build=debug

fi
