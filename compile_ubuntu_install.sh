#!/bin/bash

if [ -z $1 ]; then

./compile.sh \
	--destination-directory="$HOME/Documents/projects/LAL-dev/23.01/python-libs" \
	--build=release \
	--install

./compile.sh \
	--destination-directory="$HOME/Documents/projects/LAL-dev/23.01/python-libs" \
	--build=debug \
	--install

# for miniconda users only
elif [ "$1" == "miniconda" ]; then

miniconda_dir="/home/$USER/miniconda3"

./compile.sh \
	--destination-directory="$miniconda_dir/lib" \
	--build=release \
	--install

./compile.sh \
	--destination-directory="$miniconda_dir/lib" \
	--build=debug \
	--install

# for anaconda users only
elif [ "$1" == "anaconda" ]; then

anaconda_dir="/home/$USER/anaconda3"

./compile.sh \
	--destination-directory="$anaconda_dir/lib" \
	--build=release \
	--install

./compile.sh \
	--destination-directory="$anaconda_dir/lib" \
	--build=debug \
	--install

fi
