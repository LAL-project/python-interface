#!/bin/bash

LAL_HEADERS="C:/Users/$USER/Desktop/LAL-DISTRIBUTION/24.10/windows10-c++-libs-msys64/include"
LAL_LIBRARY="C:/Users/$USER/Desktop/LAL-DISTRIBUTION/24.10/windows10-c++-libs-msys64/bin"

if [ -z $1 ]; then

PYTHON_HEADERS="C:/msys64/mingw64/include/python3.11"
PYTHON_LIBRARY=""

./compile.sh \
	--environment=distribution \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$PYTHON_HEADERS" \
	--python-libs="$PYTHON_LIBRARY" \
	--build=release

./compile.sh \
	--environment=distribution \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$PYTHON_HEADERS" \
	--python-libs="$PYTHON_LIBRARY" \
	--build=debug

# for anaconda users only
elif [ "$1" == "anaconda" ]; then

anaconda_dir="C:/Users/$USER/anaconda3"

./compile.sh \
	--environment=distribution \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$anaconda_dir/include/" \
	--python-libs="$anaconda_dir" \
	--build=release

./compile.sh \
	--environment=distribution \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$anaconda_dir/include/" \
	--python-libs="$anaconda_dir" \
	--build=debug

fi
