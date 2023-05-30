#!/bin/bash

if [ -z $1 ]; then

./compile.sh \
	--lal-destination="C:/programming/msys64/mingw64/lib/python3.10/site-packages" \
	--build=release \
	--install

./compile.sh \
	--lal-destination="C:/programming/msys64/mingw64/lib/python3.10/site-packages" \
	--build=debug \
	--install

# for miniconda users only
elif [ "$1" == "miniconda" ]; then

miniconda_dir="C:/Users/$USER/miniconda3/Lib/site-packages"

./compile.sh \
	--lal-destination="$miniconda_dir" \
	--build=release \
	--anaconda \
	--install

./compile.sh \
	--lal-destination="$miniconda_dir" \
	--build=debug \
	--anaconda \
	--install

# for anaconda users only
elif [ "$1" == "anaconda" ]; then

anaconda_dir="C:/Users/$USER/anaconda3/Lib/site-packages"

./compile.sh \
	--lal-destination="$anaconda_dir" \
	--build=release \
	--anaconda \
	--install

./compile.sh \
	--lal-destination="$anaconda_dir" \
	--build=debug \
	--anaconda \
	--install

# for developers only
elif [ "$1" == "package" ]; then

destdir="C:/Users/$USER/Desktop/LAL-DISTRIBUTION/latest/windows10-python3.9-libs-anaconda"

./compile.sh \
	--lal-destination="$destdir" \
	--build=release \
	--anaconda \
	--install

./compile.sh \
	--lal-destination="$destdir" \
	--build=debug \
	--anaconda \
	--install

fi
