#!/bin/bash

if [ -z $1 ]; then

./compile.sh \
	--destination-directory="C:/programming/msys64/mingw64/lib/python3.10/site-packages" \
	--build=release \
	--install

./compile.sh \
	--destination-directory="C:/programming/msys64/mingw64/lib/python3.10/site-packages" \
	--build=debug \
	--install

# for miniconda users only
elif [ "$1" == "miniconda" ]; then

miniconda_dir="C:/Users/$USER/miniconda3/Lib/site-packages"

./compile.sh \
	--destination-directory="$miniconda_dir" \
	--build=release \
	--install

./compile.sh \
	--destination-directory="$miniconda_dir" \
	--build=debug \
	--install

# for anaconda users only
elif [ "$1" == "anaconda" ]; then

anaconda_dir="C:/Users/$USER/anaconda3/Lib/site-packages"

./compile.sh \
	--destination-directory="$anaconda_dir" \
	--build=release \
	--install

./compile.sh \
	--destination-directory="$anaconda_dir" \
	--build=debug \
	--install

# for developers only
elif [ "$1" == "package" ]; then

destdir="C:/Users/$USER/Desktop/LAL-DISTRIBUTION/23.01/windows10-python3.9-libs-anaconda"

./compile.sh \
	--destination-directory="$destdir" \
	--build=release \
	--install

./compile.sh \
	--destination-directory="$destdir" \
	--build=debug \
	--install

fi
