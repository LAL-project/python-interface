#!/bin/bash

if [ -z $1 ]; then

sudo \
./compile.sh \
	--lal-destination="/usr/local/lib/python3.8/dist-packages" \
	--build=release \
	--install

sudo \
./compile.sh \
	--lal-destination="/usr/local/lib/python3.8/dist-packages" \
	--build=debug \
	--install

# for miniconda users only
elif [ "$1" == "miniconda" ]; then

miniconda_dir="/home/$USER/miniconda3"

./compile.sh \
	--lal-destination="$miniconda_dir/lib" \
	--build=release \
	--anaconda \
	--install

./compile.sh \
	--lal-destination="$miniconda_dir/lib" \
	--build=debug \
	--anaconda \
	--install

# for anaconda users only
elif [ "$1" == "anaconda" ]; then

anaconda_dir="/home/$USER/anaconda3"

./compile.sh \
	--lal-destination="$anaconda_dir/lib" \
	--build=release \
	--anaconda \
	--install

./compile.sh \
	--lal-destination="$anaconda_dir/lib" \
	--build=debug \
	--anaconda \
	--install

fi
