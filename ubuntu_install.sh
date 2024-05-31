#!/bin/bash

if [ -z $1 ]; then

lal_dist_dir="$HOME/Documents/projects/LAL-dev/latest/python-libs"

./compile.sh \
	--destination-directory=$lal_dist_dir \
	--build=release \
	--install

./compile.sh \
	--destination-directory=$lal_dist_dir \
	--build=debug \
	--install

lal_cpp_dir="$HOME/Documents/projects/LAL-dev/latest/c++-libs/lib"

cp $lal_cpp_dir/liblal* $lal_dist_dir

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
