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

miniconda_dir="C:/Users/Usuari/miniconda3/Lib/site-packages"

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

anaconda_dir="C:/Users/Usuari/anaconda3/Lib/site-packages"

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

fi
