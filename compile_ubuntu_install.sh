#!/bin/bash

if [ -z $1 ]; then

./compile.sh \
	--lal-destination="/home/lluis/Documents/projects/LAL-dev/latest/python-libs" \
	--build=release \
	--install

./compile.sh \
	--lal-destination="/home/lluis/Documents/projects/LAL-dev/latest/python-libs" \
	--build=debug \
	--install

# for miniconda users only
elif [ "$1" == "miniconda" ]; then

miniconda_dir="/home/$USER/miniconda3"

./compile.sh \
	--lal-destination="$miniconda_dir/lib" \
	--build=release \
	--install

./compile.sh \
	--lal-destination="$miniconda_dir/lib" \
	--build=debug \
	--install

# for anaconda users only
elif [ "$1" == "anaconda" ]; then

anaconda_dir="/home/$USER/anaconda3"

./compile.sh \
	--lal-destination="$anaconda_dir/lib" \
	--build=release \
	--install

./compile.sh \
	--lal-destination="$anaconda_dir/lib" \
	--build=debug \
	--install

fi
