#!/bin/bash

LAL_HEADERS="$HOME/Documents/projects/LAL-dev/latest/c++-libs/include"
LAL_LIBRARY="$HOME/Documents/projects/LAL-dev/latest/c++-libs/lib"

if [ -z $1 ]; then

PYTHON_HEADERS="/usr/include/python3.10"
PYTHON_LIBRARY="/usr/lib/x86_64-linux-gnu/"

./compile.sh \
	--environment=distribution \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$PYTHON_HEADERS" \
	--build=release

./compile.sh \
	--environment=distribution \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$PYTHON_HEADERS" \
	--build=debug

# for anaconda users only
elif [ "$1" == "anaconda" ]; then

anaconda_dir="/home/$USER/anaconda3"

./compile.sh \
	--environment=distribution \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$anaconda_dir/include/python3.9" \
	--build=release

./compile.sh \
	--environment=distribution \
	--lal-headers="$LAL_HEADERS" \
	--lal-libs="$LAL_LIBRARY" \
	--gmp-headers="" \
	--gmp-libs="" \
	--python-headers="$anaconda_dir/include/python3.9" \
	--build=debug

fi
