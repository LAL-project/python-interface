#!/bin/bash

if [ -z $1 ]; then

./compile.sh \
	--destination-directory="C:/msys64/mingw64/lib/python3.10/site-packages" \
	--build=release \
	--install

./compile.sh \
	--destination-directory="C:/msys64/mingw64/lib/python3.10/site-packages" \
	--build=debug \
	--install

# for anaconda users only
elif [ "$1" == "anaconda" ]; then

anaconda_dir="C:/Users/$USER/anaconda3"
anaconda_package_dir="$anaconda_dir/Lib/site-packages"

./compile.sh \
	--destination-directory="$anaconda_dir" \
	--build=release \
	--install

./compile.sh \
	--destination-directory="$anaconda_dir" \
	--build=debug \
	--install

lal_dist_dir="C:/Users/$USER/Desktop/LAL-DISTRIBUTION"
lal_cpp_dir="$lal_dist_dir/latest/windows10-c++-libs-msys64"

# lal dlls
cp $lal_cpp_dir/bin/liblal.dll $anaconda_package_dir/lal
cp $lal_cpp_dir/bin/liblaloptimized.dll $anaconda_package_dir/laloptimized

# system dlls
cp $lal_dist_dir/libgcc_s_seh-1.dll $anaconda_dir
cp $lal_dist_dir/libgmp-10.dll $anaconda_dir
cp $lal_dist_dir/libgomp-1.dll $anaconda_dir
cp $lal_dist_dir/libstdc++-6.dll $anaconda_dir
cp $lal_dist_dir/libwinpthread-1.dll $anaconda_dir

# for developers only
elif [ "$1" == "package" ]; then

dest_dir="C:/Users/$USER/Desktop/LAL-DISTRIBUTION/latest/windows10-python3-libs-anaconda"

./compile.sh \
	--destination-directory="$dest_dir" \
	--build=release \
	--install

./compile.sh \
	--destination-directory="$dest_dir" \
	--build=debug \
	--install

lal_dist_dir="C:/Users/$USER/Desktop/LAL-DISTRIBUTION"
lal_cpp_dir="$lal_dist_dir/latest/windows10-c++-libs-msys64"

# lal dlls
cp $lal_cpp_dir/bin/liblal.dll $dest_dir/lal
cp $lal_cpp_dir/bin/liblaloptimized.dll $dest_dir/laloptimized

# system dlls
cp $lal_dist_dir/libgcc_s_seh-1.dll $dest_dir
cp $lal_dist_dir/libgmp-10.dll $dest_dir
cp $lal_dist_dir/libgomp-1.dll $dest_dir
cp $lal_dist_dir/libstdc++-6.dll $dest_dir
cp $lal_dist_dir/libwinpthread-1.dll $dest_dir

fi
